package org.dromara.web.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.stp.parameter.SaLoginParameter;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.config.AuthDefaultSource;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthUser;
import me.zhyd.oauth.request.AuthRequest;
import me.zhyd.oauth.request.AuthWechatMiniProgramRequest;
import org.dromara.common.core.constant.SystemConstants;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.core.utils.ValidatorUtils;
import org.dromara.common.json.utils.JsonUtils;
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.common.social.config.properties.SocialLoginConfigProperties;
import org.dromara.common.social.config.properties.SocialProperties;
import org.dromara.system.api.model.XcxLoginBody;
import org.dromara.system.api.model.XcxLoginUser;
import org.dromara.system.domain.vo.SysClientVo;
import org.dromara.system.domain.vo.SysSocialVo;
import org.dromara.system.domain.vo.SysUserVo;
import org.dromara.system.service.ISysConfigService;
import org.dromara.system.service.ISysSocialService;
import org.dromara.system.service.ISysUserService;
import org.dromara.web.domain.vo.LoginVo;
import org.dromara.web.service.IAuthStrategy;
import org.dromara.web.service.SysLoginService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 小程序认证策略
 *
 * @author Michelle.Chung
 */
@Slf4j
@Service("xcx" + IAuthStrategy.BASE_NAME)
@RequiredArgsConstructor
public class XcxAuthStrategy implements IAuthStrategy {

    /**
     * sys_config 参数键：小程序 appid / appsecret（优先级高于 justauth yml 配置）
     */
    private static final String CONFIG_KEY_APPID = "wx.miniapp.appid";
    private static final String CONFIG_KEY_SECRET = "wx.miniapp.secret";

    /**
     * justauth yml 中小程序配置的键（sys_config 未配置时降级使用）
     */
    private static final String JUSTAUTH_SOURCE_KEY = AuthDefaultSource.WECHAT_MINI_PROGRAM.name();

    private final SysLoginService loginService;
    private final ISysUserService userService;
    private final ISysSocialService socialService;
    private final ISysConfigService configService;
    private final SocialProperties socialProperties;

    /**
     * 执行微信小程序登录，并根据 openid 构建小程序用户登录态。
     * openid 未绑定用户时自动注册默认用户并完成绑定。
     *
     * @param body   登录请求体
     * @param client 当前客户端配置
     * @return 登录结果
     */
    @Override
    public LoginVo login(String body, SysClientVo client) {
        XcxLoginBody loginBody = JsonUtils.parseObject(body, XcxLoginBody.class);
        ValidatorUtils.validate(loginBody);
        // xcxCode 为 小程序调用 wx.login 授权后获取
        String xcxCode = loginBody.getXcxCode();
        // appid 与 appsecret 优先取 sys_config，未配置时降级 justauth yml，最后降级请求体中的 appid

        // 校验 appid + appsrcret + xcxCode 调用登录凭证校验接口 获取 session_key 与 openid
        AuthRequest authRequest = new AuthWechatMiniProgramRequest(AuthConfig.builder()
            .clientId(resolveAppid(loginBody.getAppid())).clientSecret(resolveAppSecret())
            .ignoreCheckRedirectUri(true).ignoreCheckState(true).build());
        AuthCallback authCallback = new AuthCallback();
        authCallback.setCode(xcxCode);
        AuthResponse<AuthUser> resp = authRequest.login(authCallback);
        if (!resp.ok()) {
            throw new ServiceException(resp.getMsg());
        }
        AuthUser authUser = resp.getData();
        String openid = authUser.getUuid();

        // 框架登录不限制从什么表查询 只要最终构建出 LoginUser 即可
        SysUserVo user = loadUserByOpenid(authUser);
        // 此处可根据登录用户的数据不同 自行创建 loginUser 属性不够用继承扩展就行了
        XcxLoginUser loginUser = new XcxLoginUser();
        loginUser.setUserId(user.getUserId());
        loginUser.setUsername(user.getUserName());
        loginUser.setNickname(user.getNickName());
        loginUser.setUserType(user.getUserType());
        loginUser.setClientKey(client.getClientKey());
        loginUser.setDeviceType(client.getDeviceType());
        loginUser.setOpenid(openid);

        SaLoginParameter model = IAuthStrategy.buildLoginParameter(client);
        // 生成token
        LoginHelper.login(loginUser, model);

        LoginVo loginVo = new LoginVo();
        loginVo.setAccessToken(StpUtil.getTokenValue());
        loginVo.setExpireIn(StpUtil.getTokenTimeout());
        loginVo.setClientId(client.getClientId());
        loginVo.setOpenid(openid);
        return loginVo;
    }

    /**
     * 按 openid 查询绑定用户，未绑定时自动注册默认用户并绑定。
     *
     * @param authUser JustAuth 授权用户（uuid 为 openid）
     * @return 绑定的系统用户信息
     */
    private SysUserVo loadUserByOpenid(AuthUser authUser) {
        String authId = authUser.getSource() + authUser.getUuid();
        List<SysSocialVo> socials = socialService.selectByAuthId(authId);
        if (CollUtil.isNotEmpty(socials)) {
            for (SysSocialVo social : socials) {
                SysUserVo user = userService.selectUserById(social.getUserId());
                if (ObjectUtil.isNotNull(user)) {
                    if (SystemConstants.DISABLE.equals(user.getStatus())) {
                        throw new ServiceException("登录用户：{} 已被停用.", user.getUserName());
                    }
                    return user;
                }
            }
        }
        // 未绑定用户：自动注册默认用户并绑定 openid
        Long userId = loginService.xcxRegisterAndBind(authUser);
        return userService.selectUserById(userId);
    }

    /**
     * 解析小程序 appid：sys_config → justauth yml → 请求体（多小程序场景由请求体指定）。
     *
     * @param bodyAppid 请求体中的 appid
     * @return 小程序 appid
     */
    private String resolveAppid(String bodyAppid) {
        String configAppid = configService.selectConfigByKey(CONFIG_KEY_APPID);
        if (StringUtils.isNotBlank(configAppid)) {
            return configAppid;
        }
        SocialLoginConfigProperties config = justAuthConfig();
        if (config != null && StringUtils.isNotBlank(config.getClientId())) {
            return config.getClientId();
        }
        return bodyAppid;
    }

    /**
     * 解析小程序 appsecret：sys_config → justauth yml，均为空时抛出明确错误。
     *
     * @return 小程序 appsecret
     */
    private String resolveAppSecret() {
        String configSecret = configService.selectConfigByKey(CONFIG_KEY_SECRET);
        if (StringUtils.isNotBlank(configSecret)) {
            return configSecret;
        }
        SocialLoginConfigProperties config = justAuthConfig();
        if (config != null && StringUtils.isNotBlank(config.getClientSecret())) {
            return config.getClientSecret();
        }
        throw new ServiceException("未配置小程序 appsecret：请在 sys_config 配置 wx.miniapp.secret 或 yml justauth.type.WECHAT_MINI_PROGRAM.client-secret");
    }

    /**
     * 读取 justauth yml 中小程序的配置，未配置时返回 null。
     */
    private SocialLoginConfigProperties justAuthConfig() {
        return socialProperties.getType() == null
            ? null : socialProperties.getType().get(JUSTAUTH_SOURCE_KEY);
    }

}
