--liquibase formatted sql
--changeset seewe:20260805-01-mysql-core-data
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:1 SELECT COUNT(*) FROM DATABASECHANGELOG WHERE ID = '20260805-01-mysql-core-table' AND AUTHOR = 'seewe' AND EXECTYPE = 'EXECUTED'

insert into sys_dept values(1761000000000000100, 0, '0', '总公司', null, 0, null, null, null, '0', '0', null, 1761100000000000001, sysdate(), null, null);

-- 2、用户信息表
-- ----------------------------
insert into sys_user values(1761100000000000001, 1761000000000000100, 'admin', '疯狂的狮子Li', 'sys_user', 'crazyLionLi@163.com', '15888888888', '1', null, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 1761000000000000100, 1761100000000000001, sysdate(), null, null, '管理员');
-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
insert into sys_post values(1761200000000000001, 1761000000000000103, 'ceo', null, '董事长', 1, '0', '0', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_post values(1761200000000000002, 1761000000000000100, 'se', null, '项目经理', 2, '0', '0', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_post values(1761200000000000003, 1761000000000000100, 'hr', null, '人力资源', 3, '0', '0', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_post values(1761200000000000004, 1761000000000000100, 'user', null, '普通员工', 4, '0', '0', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
insert into sys_role values(1761300000000000001, '超级管理员', 'superadmin', 1, 1, 1, 1, '0', '0', null, 1761100000000000001, sysdate(), null, null, '超级管理员');
-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
insert into sys_menu values(1761400000000000001, '系统管理', 0, 1, 'system', null, '', 'N', 'Y', 'M', '0', '0', '', 'system', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统管理目录');
insert into sys_menu values(1761400000000000002, '系统监控', 0, 3, 'monitor', null, '', 'N', 'Y', 'M', '0', '0', '', 'monitor', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统监控目录');
insert into sys_menu values(1761400000000000003, '系统工具', 0, 4, 'tool', null, '', 'N', 'Y', 'M', '0', '0', '', 'tool', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统工具目录');
-- 二级菜单
insert into sys_menu values(1761400000000000100, '用户管理', 1761400000000000001, 1, 'user', 'system/user/index', '', 'N', 'Y', 'C', '0', '0', 'system:user:list', 'user', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '用户管理菜单');
insert into sys_menu values(1761400000000000101, '角色管理', 1761400000000000001, 2, 'role', 'system/role/index', '', 'N', 'Y', 'C', '0', '0', 'system:role:list', 'peoples', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '角色管理菜单');
insert into sys_menu values(1761400000000000102, '菜单管理', 1761400000000000001, 3, 'menu', 'system/menu/index', '', 'N', 'Y', 'C', '0', '0', 'system:menu:list', 'tree-table', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '菜单管理菜单');
insert into sys_menu values(1761400000000000103, '部门管理', 1761400000000000001, 4, 'dept', 'system/dept/index', '', 'N', 'Y', 'C', '0', '0', 'system:dept:list', 'tree', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '部门管理菜单');
insert into sys_menu values(1761400000000000104, '岗位管理', 1761400000000000001, 5, 'post', 'system/post/index', '', 'N', 'Y', 'C', '0', '0', 'system:post:list', 'post', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '岗位管理菜单');
insert into sys_menu values(1761400000000000105, '字典管理', 1761400000000000001, 6, 'dict', 'system/dict/index', '', 'N', 'Y', 'C', '0', '0', 'system:dict:list', 'dict', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '字典管理菜单');
insert into sys_menu values(1761400000000000106, '参数设置', 1761400000000000001, 7, 'config', 'system/config/index', '', 'N', 'Y', 'C', '0', '0', 'system:config:list', 'edit', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '参数设置菜单');
insert into sys_menu values(1761400000000000107, '通知公告', 1761400000000000001, 8, 'notice', 'system/notice/index', '', 'N', 'Y', 'C', '0', '0', 'system:notice:list', 'message', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '通知公告菜单');
insert into sys_menu values(1761400000000000108, '日志管理', 1761400000000000001, 9, 'log', '', '', 'N', 'Y', 'M', '0', '0', '', 'log', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '日志管理菜单');
insert into sys_menu values(1761400000000000109, '在线用户', 1761400000000000002, 1, 'online', 'monitor/online/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:online:list', 'online', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '在线用户菜单');
insert into sys_menu values(1761400000000000113, '缓存监控', 1761400000000000002, 5, 'cache', 'monitor/cache/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:cache:list', 'redis', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '缓存监控菜单');
insert into sys_menu values(1761400000000000115, '代码生成', 1761400000000000003, 2, 'gen', 'tool/gen/index', '', 'N', 'Y', 'C', '0', '0', 'tool:gen:list', 'code', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '代码生成菜单');
insert into sys_menu values(1761400000000000123, '客户端管理', 1761400000000000001, 11, 'client', 'system/client/index', '', 'N', 'Y', 'C', '0', '0', 'system:client:list', 'international', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '客户端管理菜单');
insert into sys_menu values(1761400000000000116, '修改生成配置', 1761400000000000003, 2, 'gen-edit/index/:tableId', 'tool/gen/editTable', '', 'N', 'N', 'C', '1', '0', 'tool:gen:edit', '#', '/tool/gen', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000000130, '分配用户', 1761400000000000001, 2, 'role-auth/user/:roleId', 'system/role/authUser', '', 'N', 'N', 'C', '1', '0', 'system:role:edit', '#', '/system/role', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000000131, '分配角色', 1761400000000000001, 1, 'user-auth/role/:userId', 'system/user/authRole', '', 'N', 'N', 'C', '1', '0', 'system:user:edit', '#', '/system/user', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000000133, '文件配置管理', 1761400000000000001, 10, 'oss-config/index', 'system/oss/config', '', 'N', 'N', 'C', '1', '0', 'system:ossConfig:list', '#', '/system/oss', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');

-- springboot-admin监控
insert into sys_menu values(1761400000000000117, 'Admin监控', 1761400000000000002, 5, 'Admin', 'monitor/admin/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:admin:list', 'dashboard', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, 'Admin监控菜单');
-- oss菜单
insert into sys_menu values(1761400000000000118, '文件管理', 1761400000000000001, 10, 'oss', 'system/oss/index', '', 'N', 'Y', 'C', '0', '0', 'system:oss:list', 'upload', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '文件管理菜单');

-- 三级菜单
insert into sys_menu values(1761400000000000500, '操作日志', 1761400000000000108, 1, 'operlog', 'monitor/operlog/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:operlog:list', 'form', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '操作日志菜单');
insert into sys_menu values(1761400000000000501, '登录日志', 1761400000000000108, 2, 'logininfo', 'monitor/logininfo/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:logininfo:list', 'logininfo', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '登录日志菜单');
-- 用户管理按钮
insert into sys_menu values(1761400000000001001, '用户查询', 1761400000000000100, 1, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001002, '用户新增', 1761400000000000100, 2, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001003, '用户修改', 1761400000000000100, 3, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001004, '用户删除', 1761400000000000100, 4, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001005, '用户导出', 1761400000000000100, 5, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001006, '用户导入', 1761400000000000100, 6, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:import', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001007, '重置密码', 1761400000000000100, 7, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:user:resetPwd', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 角色管理按钮
insert into sys_menu values(1761400000000001008, '角色查询', 1761400000000000101, 1, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:role:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001009, '角色新增', 1761400000000000101, 2, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:role:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001010, '角色修改', 1761400000000000101, 3, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:role:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001011, '角色删除', 1761400000000000101, 4, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:role:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001012, '角色导出', 1761400000000000101, 5, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:role:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 菜单管理按钮
insert into sys_menu values(1761400000000001013, '菜单查询', 1761400000000000102, 1, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:menu:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001014, '菜单新增', 1761400000000000102, 2, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:menu:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001015, '菜单修改', 1761400000000000102, 3, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:menu:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001016, '菜单删除', 1761400000000000102, 4, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:menu:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 部门管理按钮
insert into sys_menu values(1761400000000001017, '部门查询', 1761400000000000103, 1, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:dept:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001018, '部门新增', 1761400000000000103, 2, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:dept:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001019, '部门修改', 1761400000000000103, 3, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:dept:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001020, '部门删除', 1761400000000000103, 4, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:dept:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 岗位管理按钮
insert into sys_menu values(1761400000000001021, '岗位查询', 1761400000000000104, 1, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:post:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001022, '岗位新增', 1761400000000000104, 2, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:post:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001023, '岗位修改', 1761400000000000104, 3, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:post:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001024, '岗位删除', 1761400000000000104, 4, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:post:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001025, '岗位导出', 1761400000000000104, 5, '', '', '', 'N', 'Y', 'F', '0', '0', 'system:post:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 字典管理按钮
insert into sys_menu values(1761400000000001026, '字典查询', 1761400000000000105, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:dict:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001027, '字典新增', 1761400000000000105, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:dict:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001028, '字典修改', 1761400000000000105, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:dict:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001029, '字典删除', 1761400000000000105, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:dict:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001030, '字典导出', 1761400000000000105, 5, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:dict:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 参数设置按钮
insert into sys_menu values(1761400000000001031, '参数查询', 1761400000000000106, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:config:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001032, '参数新增', 1761400000000000106, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:config:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001033, '参数修改', 1761400000000000106, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:config:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001034, '参数删除', 1761400000000000106, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:config:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001035, '参数导出', 1761400000000000106, 5, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:config:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 通知公告按钮
insert into sys_menu values(1761400000000001036, '公告查询', 1761400000000000107, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:notice:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001037, '公告新增', 1761400000000000107, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:notice:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001038, '公告修改', 1761400000000000107, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:notice:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001039, '公告删除', 1761400000000000107, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:notice:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 操作日志按钮
insert into sys_menu values(1761400000000001040, '操作查询', 1761400000000000500, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:operlog:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001041, '操作删除', 1761400000000000500, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:operlog:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001042, '日志导出', 1761400000000000500, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:operlog:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 登录日志按钮
insert into sys_menu values(1761400000000001043, '登录查询', 1761400000000000501, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:logininfo:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001044, '登录删除', 1761400000000000501, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:logininfo:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001045, '日志导出', 1761400000000000501, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:logininfo:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001050, '账户解锁', 1761400000000000501, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:logininfo:unlock', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 在线用户按钮
insert into sys_menu values(1761400000000001046, '在线查询', 1761400000000000109, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:online:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001047, '批量强退', 1761400000000000109, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:online:batchLogout', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001048, '单条强退', 1761400000000000109, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'monitor:online:forceLogout', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- 代码生成按钮
insert into sys_menu values(1761400000000001055, '生成查询', 1761400000000000115, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'tool:gen:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001056, '生成修改', 1761400000000000115, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'tool:gen:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001057, '生成删除', 1761400000000000115, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'tool:gen:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001058, '导入代码', 1761400000000000115, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'tool:gen:import', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001059, '预览代码', 1761400000000000115, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'tool:gen:preview', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001060, '生成代码', 1761400000000000115, 5, '#', '', '', 'N', 'Y', 'F', '0', '0', 'tool:gen:code', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- oss相关按钮
insert into sys_menu values(1761400000000001600, '文件查询', 1761400000000000118, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:oss:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001601, '文件上传', 1761400000000000118, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:oss:upload', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001602, '文件下载', 1761400000000000118, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:oss:download', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001603, '文件删除', 1761400000000000118, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:oss:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001620, '配置列表', 1761400000000000118, 5, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:ossConfig:list', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001621, '配置添加', 1761400000000000118, 6, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:ossConfig:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001622, '配置编辑', 1761400000000000118, 6, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:ossConfig:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001623, '配置删除', 1761400000000000118, 6, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:ossConfig:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');

-- 客户端管理按钮
insert into sys_menu values(1761400000000001061, '客户端管理查询', 1761400000000000123, 1, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:client:query', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001062, '客户端管理新增', 1761400000000000123, 2, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:client:add', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001063, '客户端管理修改', 1761400000000000123, 3, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:client:edit', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001064, '客户端管理删除', 1761400000000000123, 4, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:client:remove', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
insert into sys_menu values(1761400000000001065, '客户端管理导出', 1761400000000000123, 5, '#', '', '', 'N', 'Y', 'F', '0', '0', 'system:client:export', '#', '', '', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '');
-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
insert into sys_user_role values (1761100000000000001, 1761300000000000001);
-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
insert into sys_user_post values (1761100000000000001, 1761200000000000001);

-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
insert into sys_dict_type values(1761500000000000001, '用户性别', 'sys_user_gender', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '用户性别列表');
insert into sys_dict_type values(1761500000000000002, '菜单状态', 'sys_show_hide', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '菜单状态列表');
insert into sys_dict_type values(1761500000000000003, '系统开关', 'sys_normal_disable', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统开关列表');
insert into sys_dict_type values(1761500000000000006, '系统是否', 'sys_yes_no', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统是否列表');
insert into sys_dict_type values(1761500000000000007, '通知类型', 'sys_notice_type', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '通知类型列表');
insert into sys_dict_type values(1761500000000000008, '通知状态', 'sys_notice_status', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '通知状态列表');
insert into sys_dict_type values(1761500000000000009, '操作类型', 'sys_oper_type', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '操作类型列表');
insert into sys_dict_type values(1761500000000000010, '系统状态', 'sys_common_status', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '登录状态列表');
insert into sys_dict_type values(1761500000000000011, '授权类型', 'sys_grant_type', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '认证授权类型');
insert into sys_dict_type values(1761500000000000012, '设备类型', 'sys_device_type', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '客户端设备类型');


-- ----------------------------
-- 12、字典数据表
-- ----------------------------
insert into sys_dict_data values(1761600000000000001, 1, '男', '0', 'sys_user_gender', '', '', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '性别男');
insert into sys_dict_data values(1761600000000000002, 2, '女', '1', 'sys_user_gender', '', '', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '性别女');
insert into sys_dict_data values(1761600000000000003, 3, '未知', '2', 'sys_user_gender', '', '', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '性别未知');
insert into sys_dict_data values(1761600000000000004, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '显示菜单');
insert into sys_dict_data values(1761600000000000005, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '隐藏菜单');
insert into sys_dict_data values(1761600000000000006, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '正常状态');
insert into sys_dict_data values(1761600000000000007, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '停用状态');
insert into sys_dict_data values(1761600000000000012, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统默认是');
insert into sys_dict_data values(1761600000000000013, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '系统默认否');
insert into sys_dict_data values(1761600000000000014, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '通知');
insert into sys_dict_data values(1761600000000000015, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '公告');
insert into sys_dict_data values(1761600000000000016, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '正常状态');
insert into sys_dict_data values(1761600000000000017, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '关闭状态');
insert into sys_dict_data values(1761600000000000029, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '其他操作');
insert into sys_dict_data values(1761600000000000018, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '新增操作');
insert into sys_dict_data values(1761600000000000019, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '修改操作');
insert into sys_dict_data values(1761600000000000020, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '删除操作');
insert into sys_dict_data values(1761600000000000021, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '授权操作');
insert into sys_dict_data values(1761600000000000022, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '导出操作');
insert into sys_dict_data values(1761600000000000023, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '导入操作');
insert into sys_dict_data values(1761600000000000024, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '强退操作');
insert into sys_dict_data values(1761600000000000025, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '生成操作');
insert into sys_dict_data values(1761600000000000026, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '清空操作');
insert into sys_dict_data values(1761600000000000027, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '正常状态');
insert into sys_dict_data values(1761600000000000028, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '停用状态');
insert into sys_dict_data values(1761600000000000030, 0, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '密码认证');
insert into sys_dict_data values(1761600000000000031, 0, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '短信认证');
insert into sys_dict_data values(1761600000000000032, 0, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '邮件认证');
insert into sys_dict_data values(1761600000000000033, 0, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '小程序认证');
insert into sys_dict_data values(1761600000000000034, 0, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '三方登录认证');
insert into sys_dict_data values(1761600000000000035, 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, 'PC');
insert into sys_dict_data values(1761600000000000036, 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '安卓');
insert into sys_dict_data values(1761600000000000037, 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, 'iOS');
insert into sys_dict_data values(1761600000000000038, 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '小程序');


-- ----------------------------
-- 13、参数配置表
-- ----------------------------
insert into sys_config values(1761700000000000001, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '初始化密码 123456');
insert into sys_config values(1761700000000000002, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '是否开启注册用户功能（true开启，false关闭）');
insert into sys_config values(1761700000000000003, 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 1761000000000000103, 1761100000000000001, sysdate(), null, null, 'true:开启, false:关闭');


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
insert into sys_notice values(1761800000000000001, '温馨提醒：2018-07-01 新版本发布啦', '2', '新版本内容', '0', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '管理员');
insert into sys_notice values(1761800000000000002, '维护通知：2018-07-01 系统凌晨维护', '1', '维护内容', '0', 1761000000000000103, 1761100000000000001, sysdate(), null, null, '管理员');


-- ----------------------------
-- 18、消息记录表
-- ----------------------------
insert into sys_oss_config values (1761900000000000001, 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', 'Y', '', 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate(), null);
insert into sys_oss_config values (1761900000000000002, 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', 'N', '', 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate(), null);
insert into sys_oss_config values (1761900000000000003, 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', 'N', '', 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate(), null);
insert into sys_oss_config values (1761900000000000004, 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1240000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', 'N', '', 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate(), null);
insert into sys_oss_config values (1761900000000000005, 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', 'N', '', 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate(), null);

-- ----------------------------
-- 系统授权表
-- ----------------------------
insert into sys_client values (1762000000000000001, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', null, null, 1800, 604800, 0, 0, 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate());
insert into sys_client values (1762000000000000002, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', '/app/**', null, 1800, 604800, 0, 0, 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate());
-- 小程序客户端：grant_type 需包含 xcx（微信小程序登录）与 password（账号密码登录）
insert into sys_client values (1762000000000000003, 'f4b7e0a29d6c4815b3e7f1d2a9c60e83', 'xcx', 'xcx123', 'password,xcx', 'xcx', null, null, 1800, 604800, 0, 0, 1761000000000000103, 1761100000000000001, sysdate(), 1761100000000000001, sysdate());



-- ----------------------------
-- RuoYi-Plus-Soybean 管理端菜单与字典适配
-- 来源: seesoy-ui/docs/sql/sys_menu.sql, seesoy-ui/docs/sql/sys_dict_data.sql
-- ----------------------------

-- 目录类型菜单
UPDATE `sys_menu` SET `component` = 'Layout', `icon` = 'carbon:cloud-service-management', `menu_name` = 'route.system' WHERE `menu_id` = 1761400000000000001;
UPDATE `sys_menu` SET `component` = 'Layout', `icon` = 'stash:dashboard', `menu_name` = 'route.monitor' WHERE `menu_id` = 1761400000000000002;
UPDATE `sys_menu` SET `component` = 'Layout', `icon` = 'tabler:tools', `menu_name` = 'route.tool' WHERE `menu_id` = 1761400000000000003;
UPDATE `sys_menu` SET `component` = 'Layout', `icon` = 'tabler:logs', `menu_name` = 'menu.system_log' WHERE `menu_id` = 1761400000000000108;

-- 页面类型
UPDATE `sys_menu` SET `icon` = 'ic:round-manage-accounts', `menu_name` = 'route.system_user' WHERE `menu_id` = 1761400000000000100;
UPDATE `sys_menu` SET `icon` = 'carbon:user-role', `menu_name` = 'route.system_role' WHERE `menu_id` = 1761400000000000101;
UPDATE `sys_menu` SET `icon` = 'material-symbols:route', `menu_name` = 'route.system_menu' WHERE `menu_id` = 1761400000000000102;
UPDATE `sys_menu` SET `icon` = 'mingcute:department-line', `menu_name` = 'route.system_dept' WHERE `menu_id` = 1761400000000000103;
UPDATE `sys_menu` SET `icon` = 'hugeicons:permanent-job', `menu_name` = 'route.system_post' WHERE `menu_id` = 1761400000000000104;
UPDATE `sys_menu` SET `icon` = 'qlementine-icons:dictionary-16', `menu_name` = 'route.system_dict' WHERE `menu_id` = 1761400000000000105;
UPDATE `sys_menu` SET `icon` = 'carbon:parameter', `menu_name` = 'route.system_config' WHERE `menu_id` = 1761400000000000106;
UPDATE `sys_menu` SET `icon` = 'solar:chat-line-outline', `menu_name` = 'route.system_notice' WHERE `menu_id` = 1761400000000000107;
UPDATE `sys_menu` SET `icon` = 'majesticons:status-online-line', `menu_name` = 'route.monitor_online' WHERE `menu_id` = 1761400000000000109;
UPDATE `sys_menu` SET `icon` = 'simple-icons:redis', `menu_name` = 'route.monitor_cache' WHERE `menu_id` = 1761400000000000113;
UPDATE `sys_menu` SET `icon` = 'material-symbols:code-blocks-outline', `menu_name` = 'route.tool_gen' WHERE `menu_id` = 1761400000000000115;
UPDATE `sys_menu` SET `icon` = 'material-symbols:attach-file', `menu_name` = 'route.system_oss' WHERE `menu_id` = 1761400000000000118;
UPDATE `sys_menu` SET `icon` = 'tabler:device-imac-cog', `menu_name` = 'route.system_client' WHERE `menu_id` = 1761400000000000123;
UPDATE `sys_menu` SET `icon` = 'carbon:operations-record', `menu_name` = 'route.monitor_operlog' WHERE `menu_id` = 1761400000000000500;
UPDATE `sys_menu` SET `icon` = 'tabler:login-2', `menu_name` = 'route.monitor_logininfo' WHERE `menu_id` = 1761400000000000501;
UPDATE `sys_menu` SET `path` = 'oss/config', `component` = 'system/oss-config/index', `icon` = 'hugeicons:configuration-01', `menu_name` = 'route.system_oss-config' WHERE `menu_id` = 1761400000000000133;

-- IFrame 类型
UPDATE `sys_menu` SET `component` = 'FrameView', `query_param` = '{"url":"https://ruoyi.xlsea.cn/admin/"}', `is_frame` = 2, `icon` = 'bx:bxl-spring-boot', `menu_name` = 'menu.monitor_admin' WHERE `menu_id` = 1761400000000000117;
UPDATE `sys_menu` SET `component` = 'FrameView', `query_param` = '{"url":"https://preview.snailjob.opensnail.com/"}', `is_frame` = 2, `icon` = 'gridicons:scheduled', `menu_name` = 'menu.monitor_snail-job' WHERE `menu_id` = 1761400000000000120;
-- 外链类型

-- plus-ui 需要禁用的页面
UPDATE `sys_menu` SET `status` = '1' WHERE `menu_id` IN (1761400000000000116, 1761400000000000130, 1761400000000000131);

-- 修改字典数据表的 list_class 字段，将 danger 改为 error
UPDATE `sys_dict_data` SET `list_class` = 'error' WHERE `list_class` = 'danger';

-- 字典适配多语言
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_user_sex.male', `dict_type` = 'sys_user_sex' WHERE `dict_code` = 1;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_user_sex.female', `dict_type` = 'sys_user_sex' WHERE `dict_code` = 2;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_user_sex.unknown', `dict_type` = 'sys_user_sex' WHERE `dict_code` = 3;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_show_hide.show', `dict_type` = 'sys_show_hide' WHERE `dict_code` = 4;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_show_hide.hide', `dict_type` = 'sys_show_hide' WHERE `dict_code` = 5;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_normal_disable.normal', `dict_type` = 'sys_normal_disable' WHERE `dict_code` = 6;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_normal_disable.disable', `dict_type` = 'sys_normal_disable' WHERE `dict_code` = 7;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_yes_no.yes', `dict_type` = 'sys_yes_no' WHERE `dict_code` = 12;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_yes_no.no', `dict_type` = 'sys_yes_no' WHERE `dict_code` = 13;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_notice_type.notice', `dict_type` = 'sys_notice_type' WHERE `dict_code` = 14;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_notice_type.announcement', `dict_type` = 'sys_notice_type' WHERE `dict_code` = 15;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_notice_status.normal', `dict_type` = 'sys_notice_status' WHERE `dict_code` = 16;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_notice_status.close', `dict_type` = 'sys_notice_status' WHERE `dict_code` = 17;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.insert', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 18;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.update', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 19;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.delete', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 20;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.grant', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 21;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.export', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 22;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.import', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 23;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.force', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 24;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.gencode', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 25;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.clean', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 26;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_common_status.success', `dict_type` = 'sys_common_status' WHERE `dict_code` = 27;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_common_status.fail', `dict_type` = 'sys_common_status' WHERE `dict_code` = 28;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_oper_type.other', `dict_type` = 'sys_oper_type' WHERE `dict_code` = 29;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_grant_type.password', `dict_type` = 'sys_grant_type' WHERE `dict_code` = 30;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_grant_type.sms', `dict_type` = 'sys_grant_type' WHERE `dict_code` = 31;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_grant_type.email', `dict_type` = 'sys_grant_type' WHERE `dict_code` = 32;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_grant_type.miniapp', `dict_type` = 'sys_grant_type' WHERE `dict_code` = 33;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_grant_type.social', `dict_type` = 'sys_grant_type' WHERE `dict_code` = 34;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_device_type.pc', `dict_type` = 'sys_device_type' WHERE `dict_code` = 35;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_device_type.android', `dict_type` = 'sys_device_type' WHERE `dict_code` = 36;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_device_type.ios', `dict_type` = 'sys_device_type' WHERE `dict_code` = 37;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.sys_device_type.miniapp', `dict_type` = 'sys_device_type' WHERE `dict_code` = 38;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.revoked', `dict_type` = 'wf_business_status' WHERE `dict_code` = 39;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.draft', `dict_type` = 'wf_business_status' WHERE `dict_code` = 40;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.pending', `dict_type` = 'wf_business_status' WHERE `dict_code` = 41;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.completed', `dict_type` = 'wf_business_status' WHERE `dict_code` = 42;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.cancelled', `dict_type` = 'wf_business_status' WHERE `dict_code` = 43;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.returned', `dict_type` = 'wf_business_status' WHERE `dict_code` = 44;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_business_status.terminated', `dict_type` = 'wf_business_status' WHERE `dict_code` = 45;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_form_type.custom_form', `dict_type` = 'wf_form_type' WHERE `dict_code` = 46;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_form_type.dynamic_form', `dict_type` = 'wf_form_type' WHERE `dict_code` = 47;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.revoke', `dict_type` = 'wf_task_status' WHERE `dict_code` = 48;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.pass', `dict_type` = 'wf_task_status' WHERE `dict_code` = 49;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.pending_review', `dict_type` = 'wf_task_status' WHERE `dict_code` = 50;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.cancel', `dict_type` = 'wf_task_status' WHERE `dict_code` = 51;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.return', `dict_type` = 'wf_task_status' WHERE `dict_code` = 52;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.terminate', `dict_type` = 'wf_task_status' WHERE `dict_code` = 53;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.transfer', `dict_type` = 'wf_task_status' WHERE `dict_code` = 54;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.delegate', `dict_type` = 'wf_task_status' WHERE `dict_code` = 55;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.copy', `dict_type` = 'wf_task_status' WHERE `dict_code` = 56;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.add_sign', `dict_type` = 'wf_task_status' WHERE `dict_code` = 57;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.minus_sign', `dict_type` = 'wf_task_status' WHERE `dict_code` = 58;
UPDATE `sys_dict_data` SET `dict_label` = 'dict.wf_task_status.timeout', `dict_type` = 'wf_task_status' WHERE `dict_code` = 59;

