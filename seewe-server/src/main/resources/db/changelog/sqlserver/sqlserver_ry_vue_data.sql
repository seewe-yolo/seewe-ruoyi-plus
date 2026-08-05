--liquibase formatted sql
--changeset seewe:20260805-01-sqlserver-core-data endDelimiter:GO
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:1 SELECT COUNT(*) FROM DATABASECHANGELOG WHERE ID = '20260805-01-sqlserver-core-table' AND AUTHOR = 'seewe' AND EXECTYPE = 'EXECUTED'

INSERT sys_config VALUES (1761700000000000001, N'用户管理-账号初始密码', N'sys.user.initPassword', N'123456', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'初始化密码 123456')
GO
INSERT sys_config VALUES (1761700000000000002, N'账号自助-是否开启用户注册功能', N'sys.account.registerUser', N'false', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'是否开启注册用户功能（true开启，false关闭）')
GO
INSERT sys_config VALUES (1761700000000000003, N'OSS预览列表资源开关', N'sys.oss.previewListResource', N'true', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'true:开启, false:关闭');
GO

INSERT sys_dept VALUES (1761000000000000100, 0, N'0', N'总公司', NULL, 0, NULL, NULL, NULL, N'0', N'0', NULL, 1761100000000000001, getdate(), NULL, NULL)
GO

INSERT sys_dict_data VALUES (1761600000000000001, 1, N'男', N'0', N'sys_user_gender', N'', N'', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'性别男')
GO
INSERT sys_dict_data VALUES (1761600000000000002, 2, N'女', N'1', N'sys_user_gender', N'', N'', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'性别女')
GO
INSERT sys_dict_data VALUES (1761600000000000003, 3, N'未知', N'2', N'sys_user_gender', N'', N'', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'性别未知')
GO
INSERT sys_dict_data VALUES (1761600000000000004, 1, N'显示', N'0', N'sys_show_hide', N'', N'primary', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'显示菜单')
GO
INSERT sys_dict_data VALUES (1761600000000000005, 2, N'隐藏', N'1', N'sys_show_hide', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'隐藏菜单')
GO
INSERT sys_dict_data VALUES (1761600000000000006, 1, N'正常', N'0', N'sys_normal_disable', N'', N'primary', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'正常状态')
GO
INSERT sys_dict_data VALUES (1761600000000000007, 2, N'停用', N'1', N'sys_normal_disable', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'停用状态')
GO
INSERT sys_dict_data VALUES (1761600000000000008, 1, N'正常', N'0', N'sys_job_status', N'', N'primary', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'正常状态')
GO
INSERT sys_dict_data VALUES (1761600000000000009, 2, N'暂停', N'1', N'sys_job_status', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'停用状态')
GO
INSERT sys_dict_data VALUES (1761600000000000010, 1, N'默认', N'DEFAULT', N'sys_job_group', N'', N'', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'默认分组')
GO
INSERT sys_dict_data VALUES (1761600000000000011, 2, N'系统', N'SYSTEM', N'sys_job_group', N'', N'', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统分组')
GO
INSERT sys_dict_data VALUES (1761600000000000012, 1, N'是', N'Y', N'sys_yes_no', N'', N'primary', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统默认是')
GO
INSERT sys_dict_data VALUES (1761600000000000013, 2, N'否', N'N', N'sys_yes_no', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统默认否')
GO
INSERT sys_dict_data VALUES (1761600000000000014, 1, N'通知', N'1', N'sys_notice_type', N'', N'warning', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'通知')
GO
INSERT sys_dict_data VALUES (1761600000000000015, 2, N'公告', N'2', N'sys_notice_type', N'', N'success', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'公告')
GO
INSERT sys_dict_data VALUES (1761600000000000016, 1, N'正常', N'0', N'sys_notice_status', N'', N'primary', N'Y', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'正常状态')
GO
INSERT sys_dict_data VALUES (1761600000000000017, 2, N'关闭', N'1', N'sys_notice_status', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'关闭状态')
GO
INSERT sys_dict_data VALUES (1761600000000000029, 99, N'其他', N'0', N'sys_oper_type', N'', N'info', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'其他操作');
GO
INSERT sys_dict_data VALUES (1761600000000000018, 1, N'新增', N'1', N'sys_oper_type', N'', N'info', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'新增操作')
GO
INSERT sys_dict_data VALUES (1761600000000000019, 2, N'修改', N'2', N'sys_oper_type', N'', N'info', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'修改操作')
GO
INSERT sys_dict_data VALUES (1761600000000000020, 3, N'删除', N'3', N'sys_oper_type', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'删除操作')
GO
INSERT sys_dict_data VALUES (1761600000000000021, 4, N'授权', N'4', N'sys_oper_type', N'', N'primary', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'授权操作')
GO
INSERT sys_dict_data VALUES (1761600000000000022, 5, N'导出', N'5', N'sys_oper_type', N'', N'warning', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'导出操作')
GO
INSERT sys_dict_data VALUES (1761600000000000023, 6, N'导入', N'6', N'sys_oper_type', N'', N'warning', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'导入操作')
GO
INSERT sys_dict_data VALUES (1761600000000000024, 7, N'强退', N'7', N'sys_oper_type', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'强退操作')
GO
INSERT sys_dict_data VALUES (1761600000000000025, 8, N'生成代码', N'8', N'sys_oper_type', N'', N'warning', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'生成操作')
GO
INSERT sys_dict_data VALUES (1761600000000000026, 9, N'清空数据', N'9', N'sys_oper_type', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'清空操作')
GO
INSERT sys_dict_data VALUES (1761600000000000027, 1, N'成功', N'0', N'sys_common_status', N'', N'primary', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'正常状态')
GO
INSERT sys_dict_data VALUES (1761600000000000028, 2, N'失败', N'1', N'sys_common_status', N'', N'danger', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'停用状态')
GO
INSERT sys_dict_data VALUES (1761600000000000030, 0, N'密码认证', N'password', N'sys_grant_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'密码认证')
GO
INSERT sys_dict_data VALUES (1761600000000000031, 0, N'短信认证', N'sms', N'sys_grant_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'短信认证')
GO
INSERT sys_dict_data VALUES (1761600000000000032, 0, N'邮件认证', N'email', N'sys_grant_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'邮件认证')
GO
INSERT sys_dict_data VALUES (1761600000000000033, 0, N'小程序认证', N'xcx', N'sys_grant_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'小程序认证')
GO
INSERT sys_dict_data VALUES (1761600000000000034, 0, N'三方登录认证', N'social', N'sys_grant_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'三方登录认证')
GO
INSERT sys_dict_data VALUES (1761600000000000035, 0, N'PC', N'pc', N'sys_device_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'PC')
GO
INSERT sys_dict_data VALUES (1761600000000000036, 0, N'安卓', N'android', N'sys_device_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'安卓')
GO
INSERT sys_dict_data VALUES (1761600000000000037, 0, N'iOS', N'ios', N'sys_device_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'iOS')
GO
INSERT sys_dict_data VALUES (1761600000000000038, 0, N'小程序', N'xcx', N'sys_device_type', N'', N'default', N'N', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'小程序')
GO

INSERT sys_dict_type VALUES (1761500000000000001, N'用户性别', N'sys_user_gender', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'用户性别列表')
GO
INSERT sys_dict_type VALUES (1761500000000000002, N'菜单状态', N'sys_show_hide', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'菜单状态列表')
GO
INSERT sys_dict_type VALUES (1761500000000000003, N'系统开关', N'sys_normal_disable', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统开关列表')
GO
INSERT sys_dict_type VALUES (1761500000000000004, N'任务状态', N'sys_job_status', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'任务状态列表')
GO
INSERT sys_dict_type VALUES (1761500000000000005, N'任务分组', N'sys_job_group', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'任务分组列表')
GO
INSERT sys_dict_type VALUES (1761500000000000006, N'系统是否', N'sys_yes_no', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统是否列表')
GO
INSERT sys_dict_type VALUES (1761500000000000007, N'通知类型', N'sys_notice_type', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'通知类型列表')
GO
INSERT sys_dict_type VALUES (1761500000000000008, N'通知状态', N'sys_notice_status', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'通知状态列表')
GO
INSERT sys_dict_type VALUES (1761500000000000009, N'操作类型', N'sys_oper_type', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'操作类型列表')
GO
INSERT sys_dict_type VALUES (1761500000000000010, N'系统状态', N'sys_common_status', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'登录状态列表')
GO
INSERT sys_dict_type VALUES (1761500000000000011, N'授权类型', N'sys_grant_type', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'认证授权类型')
GO
INSERT sys_dict_type VALUES (1761500000000000012, N'设备类型', N'sys_device_type', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'客户端设备类型')
GO

insert into sys_menu values(1761400000000000001, N'系统管理', 0, 1, N'system', NULL, N'', N'N', N'Y', N'M', N'0', N'0', N'', N'system', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统管理目录');
GO
insert into sys_menu values(1761400000000000002, N'系统监控', 0, 3, N'monitor', NULL, N'', N'N', N'Y', N'M', N'0', N'0', N'', N'monitor', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统监控目录');
GO
insert into sys_menu values(1761400000000000003, N'系统工具', 0, 4, N'tool', NULL, N'', N'N', N'Y', N'M', N'0', N'0', N'', N'tool', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'系统工具目录');
GO
insert into sys_menu values(1761400000000000100, N'用户管理', 1761400000000000001, 1, N'user', N'system/user/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:user:list', N'user', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'用户管理菜单');
GO
insert into sys_menu values(1761400000000000101, N'角色管理', 1761400000000000001, 2, N'role', N'system/role/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:role:list', N'peoples', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'角色管理菜单');
GO
insert into sys_menu values(1761400000000000102, N'菜单管理', 1761400000000000001, 3, N'menu', N'system/menu/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:menu:list', N'tree-table', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'菜单管理菜单');
GO
insert into sys_menu values(1761400000000000103, N'部门管理', 1761400000000000001, 4, N'dept', N'system/dept/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:dept:list', N'tree', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'部门管理菜单');
GO
insert into sys_menu values(1761400000000000104, N'岗位管理', 1761400000000000001, 5, N'post', N'system/post/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:post:list', N'post', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'岗位管理菜单');
GO
insert into sys_menu values(1761400000000000105, N'字典管理', 1761400000000000001, 6, N'dict', N'system/dict/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:dict:list', N'dict', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'字典管理菜单');
GO
insert into sys_menu values(1761400000000000106, N'参数设置', 1761400000000000001, 7, N'config', N'system/config/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:config:list', N'edit', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'参数设置菜单');
GO
insert into sys_menu values(1761400000000000107, N'通知公告', 1761400000000000001, 8, N'notice', N'system/notice/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:notice:list', N'message', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'通知公告菜单');
GO
insert into sys_menu values(1761400000000000108, N'日志管理', 1761400000000000001, 9, N'log', N'', N'', N'N', N'Y', N'M', N'0', N'0', N'', N'log', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'日志管理菜单');
GO
insert into sys_menu values(1761400000000000109, N'在线用户', 1761400000000000002, 1, N'online', N'monitor/online/index', N'', N'N', N'Y', N'C', N'0', N'0', N'monitor:online:list', N'online', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'在线用户菜单');
GO
insert into sys_menu values(1761400000000000113, N'缓存监控', 1761400000000000002, 5, N'cache', N'monitor/cache/index', N'', N'N', N'Y', N'C', N'0', N'0', N'monitor:cache:list', N'redis', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'缓存监控菜单');
GO
insert into sys_menu values(1761400000000000115, N'代码生成', 1761400000000000003, 2, N'gen', N'tool/gen/index', N'', N'N', N'Y', N'C', N'0', N'0', N'tool:gen:list', N'code', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'代码生成菜单');
GO
insert into sys_menu values(1761400000000000123, N'客户端管理', 1761400000000000001, 11, N'client', N'system/client/index', N'', N'N', N'Y', N'C', N'0', N'0', N'system:client:list', N'international', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'客户端管理菜单');
GO
insert into sys_menu values(1761400000000000116, N'修改生成配置', 1761400000000000003, 2, N'gen-edit/index/:tableId', N'tool/gen/editTable', N'', N'N', N'N', N'C', N'1', N'0', N'tool:gen:edit', N'#', N'/tool/gen', N'', 1761000000000000103, 1761100000000000001, getdate(), null, null, N'');
GO
insert into sys_menu values(1761400000000000130, N'分配用户', 1761400000000000001, 2, N'role-auth/user/:roleId', N'system/role/authUser', N'', N'N', N'N', N'C', N'1', N'0', N'system:role:edit', N'#', N'/system/role', N'', 1761000000000000103, 1761100000000000001, getdate(), null, null, N'');
GO
insert into sys_menu values(1761400000000000131, N'分配角色', 1761400000000000001, 1, N'user-auth/role/:userId', N'system/user/authRole', N'', N'N', N'N', N'C', N'1', N'0', N'system:user:edit', N'#', N'/system/user', N'', 1761000000000000103, 1761100000000000001, getdate(), null, null, N'');
GO
insert into sys_menu values(1761400000000000133, N'文件配置管理', 1761400000000000001, 10, N'oss-config/index', N'system/oss/config', N'', N'N', N'N', N'C', N'1', N'0', N'system:ossConfig:list', N'#', N'/system/oss', N'', 1761000000000000103, 1761100000000000001, getdate(), null, null, N'');
GO

insert into sys_menu values(1761400000000000117, N'Admin监控', 1761400000000000002, 5, N'Admin', N'monitor/admin/index', N'', N'N', N'Y', N'C', N'0', N'0', N'monitor:admin:list', N'dashboard', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'Admin监控菜单');
GO
insert into sys_menu values(1761400000000000118, N'文件管理', 1761400000000000001, 10, N'oss', N'system/oss/index', N'', N'N', N'Y', N'C', '0', N'0', N'system:oss:list', N'upload', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'文件管理菜单');
GO
insert into sys_menu values(1761400000000000500, N'操作日志', 1761400000000000108, 1, N'operlog', N'monitor/operlog/index', N'', N'N', N'Y', N'C', N'0', N'0', N'monitor:operlog:list', N'form', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'操作日志菜单');
GO
insert into sys_menu values(1761400000000000501, N'登录日志', 1761400000000000108, 2, N'logininfo', N'monitor/logininfo/index', N'', N'N', N'Y', N'C', N'0', N'0', N'monitor:logininfo:list', N'logininfo', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'登录日志菜单');
GO
insert into sys_menu values(1761400000000001001, N'用户查询', 1761400000000000100, 1, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001002, N'用户新增', 1761400000000000100, 2, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001003, N'用户修改', 1761400000000000100, 3, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001004, N'用户删除', 1761400000000000100, 4, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001005, N'用户导出', 1761400000000000100, 5, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001006, N'用户导入', 1761400000000000100, 6, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:import', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001007, N'重置密码', 1761400000000000100, 7, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:user:resetPwd', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001008, N'角色查询', 1761400000000000101, 1, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:role:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001009, N'角色新增', 1761400000000000101, 2, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:role:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001010, N'角色修改', 1761400000000000101, 3, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:role:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001011, N'角色删除', 1761400000000000101, 4, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:role:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001012, N'角色导出', 1761400000000000101, 5, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:role:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001013, N'菜单查询', 1761400000000000102, 1, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:menu:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001014, N'菜单新增', 1761400000000000102, 2, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:menu:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001015, N'菜单修改', 1761400000000000102, 3, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:menu:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001016, N'菜单删除', 1761400000000000102, 4, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:menu:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001017, N'部门查询', 1761400000000000103, 1, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dept:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001018, N'部门新增', 1761400000000000103, 2, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dept:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001019, N'部门修改', 1761400000000000103, 3, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dept:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001020, N'部门删除', 1761400000000000103, 4, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dept:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001021, N'岗位查询', 1761400000000000104, 1, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:post:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001022, N'岗位新增', 1761400000000000104, 2, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:post:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001023, N'岗位修改', 1761400000000000104, 3, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:post:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001024, N'岗位删除', 1761400000000000104, 4, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:post:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001025, N'岗位导出', 1761400000000000104, 5, N'', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:post:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001026, N'字典查询', 1761400000000000105, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dict:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001027, N'字典新增', 1761400000000000105, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dict:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001028, N'字典修改', 1761400000000000105, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dict:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001029, N'字典删除', 1761400000000000105, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dict:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001030, N'字典导出', 1761400000000000105, 5, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:dict:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001031, N'参数查询', 1761400000000000106, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:config:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001032, N'参数新增', 1761400000000000106, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:config:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001033, N'参数修改', 1761400000000000106, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:config:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001034, N'参数删除', 1761400000000000106, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:config:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001035, N'参数导出', 1761400000000000106, 5, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:config:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001036, N'公告查询', 1761400000000000107, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:notice:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001037, N'公告新增', 1761400000000000107, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:notice:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001038, N'公告修改', 1761400000000000107, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:notice:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001039, N'公告删除', 1761400000000000107, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:notice:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001040, N'操作查询', 1761400000000000500, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:operlog:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001041, N'操作删除', 1761400000000000500, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:operlog:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001042, N'日志导出', 1761400000000000500, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:operlog:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001043, N'登录查询', 1761400000000000501, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:logininfo:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001044, N'登录删除', 1761400000000000501, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:logininfo:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001045, N'日志导出', 1761400000000000501, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:logininfo:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001050, N'账户解锁', 1761400000000000501, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:logininfo:unlock', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001046, N'在线查询', 1761400000000000109, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:online:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001047, N'批量强退', 1761400000000000109, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:online:batchLogout', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001048, N'单条强退', 1761400000000000109, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'monitor:online:forceLogout', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001055, N'生成查询', 1761400000000000115, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'tool:gen:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001056, N'生成修改', 1761400000000000115, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'tool:gen:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001057, N'生成删除', 1761400000000000115, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'tool:gen:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001058, N'导入代码', 1761400000000000115, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'tool:gen:import', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001059, N'预览代码', 1761400000000000115, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'tool:gen:preview', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001060, N'生成代码', 1761400000000000115, 5, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'tool:gen:code', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
-- oss相关按钮
insert into sys_menu values(1761400000000001600, N'文件查询', 1761400000000000118, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:oss:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001601, N'文件上传', 1761400000000000118, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:oss:upload', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001602, N'文件下载', 1761400000000000118, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:oss:download', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001603, N'文件删除', 1761400000000000118, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:oss:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001620, N'配置列表', 1761400000000000118, 5, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:ossConfig:list', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001621, N'配置添加', 1761400000000000118, 6, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:ossConfig:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001622, N'配置编辑', 1761400000000000118, 6, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:ossConfig:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001623, N'配置删除', 1761400000000000118, 6, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:ossConfig:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
-- 客户端管理按钮
insert into sys_menu values(1761400000000001061, N'客户端管理查询', 1761400000000000123, 1, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:client:query', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001062, N'客户端管理新增', 1761400000000000123, 2, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:client:add', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001063, N'客户端管理修改', 1761400000000000123, 3, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:client:edit', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001064, N'客户端管理删除', 1761400000000000123, 4, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:client:remove', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
insert into sys_menu values(1761400000000001065, N'客户端管理导出', 1761400000000000123, 5, N'#', N'', N'', N'N', N'Y', N'F', N'0', N'0', N'system:client:export', N'#', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'');
GO
GO
GO
GO
GO
GO
GO

GO
GO
GO
GO
GO
GO

INSERT sys_notice VALUES (1761800000000000001, N'温馨提醒：2018-07-01 若依新版本发布啦', N'2', N'新版本内容', N'0', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'管理员')
GO
INSERT sys_notice VALUES (1761800000000000002, N'维护通知：2018-07-01 若依系统凌晨维护', N'1', N'维护内容', N'0', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'管理员')
GO

INSERT sys_post VALUES (1761200000000000001, 1761000000000000103, N'ceo', NULL, N'董事长', 1, N'0', N'0', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'')
GO
INSERT sys_post VALUES (1761200000000000002, 1761000000000000100, N'se', NULL, N'项目经理', 2, N'0', N'0', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'')
GO
INSERT sys_post VALUES (1761200000000000003, 1761000000000000100, N'hr', NULL, N'人力资源', 3, N'0', N'0', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'')
GO
INSERT sys_post VALUES (1761200000000000004, 1761000000000000100, N'user', NULL, N'普通员工', 4, N'0', N'0', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'')
GO

INSERT sys_role VALUES (1761300000000000001, N'超级管理员', N'superadmin', 1, N'1', 1, 1, N'0', N'0', NULL, 1761100000000000001, getdate(), NULL, NULL, N'超级管理员')
GO

INSERT sys_user VALUES (1761100000000000001, 1761000000000000100, N'admin', N'疯狂的狮子Li', N'sys_user', N'crazyLionLi@163.com', N'15888888888', N'1', NULL, N'$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', N'0', N'0', N'127.0.0.1', getdate(), 1761000000000000100, 1761100000000000001, getdate(), NULL, NULL, N'管理员')
GO

INSERT sys_user_post VALUES (1761100000000000001, 1761200000000000001)
GO

INSERT sys_user_role VALUES (1761100000000000001, 1761300000000000001)
GO

INSERT INTO sys_oss_config VALUES (1761900000000000001, N'minio', N'ruoyi', N'ruoyi123', N'ruoyi', N'', N'127.0.0.1:9000', N'', N'N', N'', N'1', N'Y', N'', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate(), NULL);
GO
INSERT INTO sys_oss_config VALUES (1761900000000000002, N'qiniu', N'XXXXXXXXXXXXXXXX', N'XXXXXXXXXXXXXXX', N'ruoyi', N'', N's3-cn-north-1.qiniucs.com', N'', N'N', N'', N'1', N'N', N'', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate(), NULL);
GO
INSERT INTO sys_oss_config VALUES (1761900000000000003, N'aliyun', N'XXXXXXXXXXXXXXX', N'XXXXXXXXXXXXXXX', N'ruoyi', N'', N'oss-cn-beijing.aliyuncs.com', N'', N'N', N'', N'1', N'N', N'', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate(), NULL);
GO
INSERT INTO sys_oss_config VALUES (1761900000000000004, N'qcloud', N'XXXXXXXXXXXXXXX', N'XXXXXXXXXXXXXXX', N'ruoyi-1250000000', N'', N'cos.ap-beijing.myqcloud.com', N'', N'N', N'ap-beijing', N'1', N'N', N'', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate(), NULL);
GO
INSERT INTO sys_oss_config VALUES (1761900000000000005, N'image', N'ruoyi', N'ruoyi123', N'ruoyi', N'image', N'127.0.0.1:9000', N'', N'N', N'', N'1', N'N', N'', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate(), NULL);
GO


INSERT INTO sys_client VALUES (1762000000000000001, N'e5cd7e4891bf95d1d19206ce24a7b32e', N'pc', N'pc123', N'password,social', N'pc', N'', N'', 1800, 604800, N'0', N'0', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate());
GO
INSERT INTO sys_client VALUES (1762000000000000002, N'428a8310cd442757ae699df5d894f051', N'app', N'app123', N'password,sms,social', N'android', N'/app/**', N'', 1800, 604800, N'0', N'0', 1761000000000000103, 1761100000000000001, getdate(), 1761100000000000001, getdate());
GO
GO
