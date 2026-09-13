package org.dromara.web.service;

import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.Opt;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.crypto.digest.BCrypt;
import com.baomidou.lock.annotation.Lock4j;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.zhyd.oauth.model.AuthUser;
import org.dromara.common.core.constant.CacheNames;
import org.dromara.common.core.constant.Constants;
import org.dromara.common.core.constant.SystemConstants;
import org.dromara.common.core.enums.LoginType;
import org.dromara.common.core.enums.UserType;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.exception.user.UserException;
import org.dromara.common.core.utils.*;
import org.dromara.common.log.event.LoginInfoEvent;
import org.dromara.common.mybatis.helper.DataPermissionHelper;
import org.dromara.common.redis.utils.RedisUtils;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.system.api.domain.PostDTO;
import org.dromara.system.api.domain.RoleDTO;
import org.dromara.system.api.model.LoginUser;
import org.dromara.system.domain.SysUser;
import org.dromara.system.domain.bo.SysSocialBo;
import org.dromara.system.domain.bo.SysUserBo;
import org.dromara.system.domain.vo.*;
import org.dromara.system.mapper.SysUserMapper;
import org.dromara.system.service.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.function.Supplier;

/**
 * 登录校验方法
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Slf4j
@Service
public class SysLoginService {

    /**
     * 最大重试次数。
     */
    @Value("${user.password.maxRetryCount}")
    private Integer maxRetryCount;

    /**
     * 锁定时间。
     */
    @Value("${user.password.lockTime}")
    private Integer lockTime;

    private final ISysPermissionService permissionService;
    private final ISysSocialService sysSocialService;
    private final ISysRoleService roleService;
    private final ISysDeptService deptService;
    private final ISysPostService postService;
    private final ISysUserService userService;
    private final SysUserMapper userMapper;


    /**
     * 绑定第三方用户
     *
     * @param authUserData 授权响应实体
     */
    @Lock4j
    public void socialRegister(AuthUser authUserData) {
        String authId = authUserData.getSource() + authUserData.getUuid();
        // 第三方用户信息
        SysSocialBo bo = BeanUtil.toBean(authUserData, SysSocialBo.class);
        BeanUtil.copyProperties(authUserData.getToken(), bo);
        Long userId = LoginHelper.getUserId();
        bo.setUserId(userId);
        bo.setAuthId(authId);
        bo.setOpenId(authUserData.getUuid());
        bo.setUserName(authUserData.getUsername());
        bo.setNickName(authUserData.getNickname());
        List<SysSocialVo> checkList = sysSocialService.selectByAuthId(authId);
        if (CollUtil.isNotEmpty(checkList)) {
            throw new ServiceException("此三方账号已经被绑定!");
        }
        // 查询是否已经绑定用户
        SysSocialBo params = new SysSocialBo();
        params.setUserId(userId);
        params.setSource(bo.getSource());
        List<SysSocialVo> list = sysSocialService.queryList(params);
        if (CollUtil.isEmpty(list)) {
            // 没有绑定用户, 新增用户信息
            sysSocialService.insertByBo(bo);
        } else {
            // 更新用户信息
            bo.setId(list.getFirst().getId());
            sysSocialService.updateByBo(bo);
            // 如果要绑定的平台账号已经被绑定过了 是否抛异常自行决断
            // throw new ServiceException("此平台账号已经被绑定!");
        }
    }

    /**
     * 小程序用户自动注册并绑定 openid。
     * <p>账号使用 openid（天然唯一），昵称随机生成，密码随机（不支持密码登录）；
     * 注册与绑定在同一事务中完成，并发场景由 Lock4j 串行化，避免同一 openid 重复建户。</p>
     *
     * @param authUser JustAuth 授权用户（uuid 为 openid，token 中为 session_key）
     * @return 注册或复用的用户ID
     */
    @Lock4j(expire = 6000, acquireTimeout = 3000)
    @Transactional(rollbackFor = Exception.class)
    public Long xcxRegisterAndBind(AuthUser authUser) {
        String openid = authUser.getUuid();
        String authId = authUser.getSource() + openid;
        // 双重检查：并发等待期间可能已被其他请求注册绑定
        List<SysSocialVo> bindList = sysSocialService.selectByAuthId(authId);
        if (CollUtil.isNotEmpty(bindList)) {
            return bindList.getFirst().getUserId();
        }
        // 复用同名历史账号（如早期未绑定 openid 的数据），避免重复建户
        SysUserVo user = userService.selectUserByUserName(openid);
        Long userId;
        String nickName;
        if (ObjectUtil.isNotNull(user)) {
            userId = user.getUserId();
            nickName = user.getNickName();
        } else {
            SysUserBo newUser = new SysUserBo();
            newUser.setUserName(openid);
            newUser.setNickName("微信用户" + RandomUtil.randomString(6));
            newUser.setUserType(UserType.APP_USER.getUserType());
            newUser.setPassword(BCrypt.hashpw(RandomUtil.randomString(32)));
            newUser.setStatus(SystemConstants.NORMAL);
            if (!userService.registerUser(newUser)) {
                throw new ServiceException("小程序用户注册失败");
            }
            userId = userService.selectUserByUserName(openid).getUserId();
            nickName = newUser.getNickName();
        }
        // 绑定 openid 与用户（sys_social.access_token 非空约束，存入 session_key）
        SysSocialBo social = new SysSocialBo();
        social.setAuthId(authId);
        social.setSource(authUser.getSource());
        social.setOpenId(openid);
        social.setUserId(userId);
        social.setUserName(openid);
        social.setNickName(nickName);
        social.setAccessToken(StringUtils.blankToDefault(authUser.getToken().getAccessToken(), ""));
        social.setUnionId(authUser.getToken().getUnionId());
        sysSocialService.insertByBo(social);
        return userId;
    }


    /**
     * 退出登录
     */
    public void logout() {
        try {
            LoginUser loginUser = LoginHelper.getLoginUser();
            if (ObjectUtil.isNull(loginUser)) {
                return;
            }
            recordLoginInfo(loginUser.getUsername(), Constants.LOGOUT, MessageUtils.message("user.logout.success"));
        } catch (NotLoginException ignored) {
        } finally {
            try {
                StpUtil.logout();
            } catch (NotLoginException ignored) {
            }
        }
    }

    /**
     * 记录登录信息
     *
     * @param username 用户名
     * @param status   状态
     * @param message  消息内容
     */
    public void recordLoginInfo(String username, String status, String message) {
        LoginInfoEvent loginInfoEvent = new LoginInfoEvent();
        loginInfoEvent.setUsername(username);
        loginInfoEvent.setStatus(status);
        loginInfoEvent.setMessage(message);
        HttpServletRequest request = ServletUtils.getRequest();
        if (request != null) {
            loginInfoEvent.setIp(ServletUtils.getClientIP(request));
            loginInfoEvent.setUserAgent(request.getHeader("User-Agent"));
            loginInfoEvent.setClientId(request.getHeader(LoginHelper.CLIENT_KEY));
        }
        SpringUtils.context().publishEvent(loginInfoEvent);
    }

    /**
     * 根据用户视图对象组装登录态上下文。
     *
     * @param user 用户基础信息
     * @return 包含部门、角色、岗位与权限数据的登录用户
     */
    public LoginUser buildLoginUser(SysUserVo user) {
        LoginUser loginUser = new LoginUser();
        Long userId = user.getUserId();
        loginUser.setUserId(userId);
        loginUser.setDeptId(user.getDeptId());
        loginUser.setUsername(user.getUserName());
        loginUser.setNickname(user.getNickName());
        loginUser.setUserType(user.getUserType());
        if (ObjectUtil.isNotNull(user.getDeptId())) {
            Opt<SysDeptVo> deptOpt = Opt.of(user.getDeptId()).map(deptService::selectDeptById);
            loginUser.setDeptName(deptOpt.map(SysDeptVo::getDeptName).orElse(StringUtils.EMPTY));
            loginUser.setDeptCategory(deptOpt.map(SysDeptVo::getDeptCategory).orElse(StringUtils.EMPTY));
        }
        ThreadUtils.virtualInvokeAll(() -> {
            loginUser.setMenuPermission(permissionService.getMenuPermission(userId));
        }, () -> {
            loginUser.setRolePermission(permissionService.getRolePermission(userId));
        }, () -> {
            List<SysRoleVo> roles = roleService.selectRolesByUserId(userId);
            List<RoleDTO> roleDtos = BeanUtil.copyToList(roles, RoleDTO.class);
            loginUser.setRoles(roleDtos);
            loginUser.setDataScopeRoleMap(permissionService.getDataScopeRoleMap(roleDtos));
        }, () -> {
            List<SysPostVo> posts = postService.selectPostsByUserId(userId);
            loginUser.setPosts(BeanUtil.copyToList(posts, PostDTO.class));
        });
        return loginUser;
    }

    /**
     * 更新用户最近一次登录IP与登录时间。
     *
     * @param userId 用户ID
     * @param ip     登录IP
     */
    public void updateLastLoginInfo(Long userId, String ip) {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        sysUser.setLoginIp(ip);
        sysUser.setLoginDate(LocalDateTime.now());
        sysUser.setUpdateBy(userId);
        DataPermissionHelper.ignore(() -> userMapper.updateById(sysUser));
    }

    /**
     * 执行登录失败次数校验，并在成功后清空失败计数。
     *
     * @param loginType 登录类型
     * @param username  登录标识
     * @param supplier  返回 {@code true} 表示本次认证失败
     */
    public void checkLogin(LoginType loginType, String username, Supplier<Boolean> supplier) {
        String errorKey = CacheNames.PWD_ERR_CNT_KEY + username;
        String loginFail = Constants.LOGIN_FAIL;

        // 获取用户登录错误次数，默认为0 (可自定义限制策略 例如: key + username + ip)
        int errorNumber = ObjectUtil.defaultIfNull(RedisUtils.getCacheObject(errorKey), 0);
        // 锁定时间内登录 则踢出
        if (errorNumber >= maxRetryCount) {
            recordLoginInfo(username, loginFail, MessageUtils.message(loginType.getRetryLimitExceed(), maxRetryCount, lockTime));
            throw new UserException(loginType.getRetryLimitExceed(), maxRetryCount, lockTime);
        }

        if (supplier.get()) {
            // 错误次数递增
            errorNumber++;
            RedisUtils.setCacheObject(errorKey, errorNumber, Duration.ofMinutes(lockTime));
            // 达到规定错误次数 则锁定登录
            if (errorNumber >= maxRetryCount) {
                recordLoginInfo(username, loginFail, MessageUtils.message(loginType.getRetryLimitExceed(), maxRetryCount, lockTime));
                throw new UserException(loginType.getRetryLimitExceed(), maxRetryCount, lockTime);
            } else {
                // 未达到规定错误次数
                recordLoginInfo(username, loginFail, MessageUtils.message(loginType.getRetryLimitCount(), errorNumber));
                throw new UserException(loginType.getRetryLimitCount(), errorNumber);
            }
        }

        // 登录成功 清空错误次数
        RedisUtils.deleteObject(errorKey);
    }

}
