--liquibase formatted sql
--changeset seewe:20260805-01-oracle-core-table
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM user_tables WHERE table_name = 'SYS_USER'

-- ----------------------------
-- 第三方平台授权表
-- ----------------------------
create table sys_social
(
    id                 number(20)        not null,
    user_id            number(20)        not null,
    auth_id            varchar2(255)     not null,
    source             varchar2(255)     not null,
    open_id            varchar2(255)     default null,
    user_name          varchar2(30)      not null,
    nick_name          varchar2(30)      default '',
    email              varchar2(255)     default '',
    avatar             varchar2(500)     default '',
    access_token       varchar2(2000)    not null,
    expire_in          number(20)        default null,
    refresh_token      varchar2(2000)    default null,
    access_code        varchar2(255)     default null,
    union_id           varchar2(255)     default null,
    scope              varchar2(255)     default null,
    token_type         varchar2(255)     default null,
    id_token           varchar2(2000)    default null,
    mac_algorithm      varchar2(255)     default null,
    mac_key            varchar2(255)     default null,
    code               varchar2(255)     default null,
    oauth_token        varchar2(255)     default null,
    oauth_token_secret varchar2(255)     default null,
    create_dept        number(20),
    create_by          number(20),
    create_time        date,
    update_by          number(20),
    update_time        date,
    del_flag           char(1)          default '0'
);

alter table sys_social add constraint pk_sys_social primary key (id);

comment on table   sys_social                   is '社会化关系表';
comment on column  sys_social.id                is '主键';
comment on column  sys_social.user_id           is '用户ID';
comment on column  sys_social.auth_id           is '平台+平台唯一id';
comment on column  sys_social.source            is '用户来源';
comment on column  sys_social.open_id           is '平台编号唯一id';
comment on column  sys_social.user_name         is '登录账号';
comment on column  sys_social.nick_name         is '用户昵称';
comment on column  sys_social.email             is '用户邮箱';
comment on column  sys_social.avatar            is '头像地址';
comment on column  sys_social.access_token      is '用户的授权令牌';
comment on column  sys_social.expire_in         is '用户的授权令牌的有效期，部分平台可能没有';
comment on column  sys_social.refresh_token     is '刷新令牌，部分平台可能没有';
comment on column  sys_social.access_code       is '平台的授权信息，部分平台可能没有';
comment on column  sys_social.union_id          is '用户的 unionid';
comment on column  sys_social.scope             is '授予的权限，部分平台可能没有';
comment on column  sys_social.token_type        is '个别平台的授权信息，部分平台可能没有';
comment on column  sys_social.id_token          is 'id token，部分平台可能没有';
comment on column  sys_social.mac_algorithm     is '小米平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.mac_key           is '小米平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.code              is '用户的授权code，部分平台可能没有';
comment on column  sys_social.oauth_token       is 'Twitter平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.oauth_token_secret is 'Twitter平台用户的附带属性，部分平台可能没有';
comment on column  sys_social.create_dept       is '创建部门';
comment on column  sys_social.create_by         is '创建者';
comment on column  sys_social.create_time       is '创建时间';
comment on column  sys_social.update_by         is '更新者';
comment on column  sys_social.update_time       is '更新时间';
comment on column  sys_social.del_flag          is '删除标志（0代表存在 1代表删除）';

-- ----------------------------
-- 1、部门表
-- ----------------------------
create table sys_dept (
  dept_id           number(20)      not null,
  parent_id         number(20)      default 0,
  ancestors         varchar2(500)   default '',
  dept_name         varchar2(30)    default '',
  dept_category     varchar2(100)   default null,
  order_num         number(4)       default 0,
  leader            number(20)     default null,
  phone             varchar2(11)    default null,
  email             varchar2(50)    default null,
  status            char(1)         default '0',
  del_flag          char(1)         default '0',
  create_dept       number(20)      default null,
  create_by         number(20)      default null,
  create_time       date,
  update_by         number(20)      default null,
  update_time       date
);

alter table sys_dept add constraint pk_sys_dept primary key (dept_id);

create index idx_sys_dept_parent_id on sys_dept (parent_id);

comment on table  sys_dept              is '部门表';
comment on column sys_dept.dept_id      is '部门id';
comment on column sys_dept.parent_id    is '父部门id';
comment on column sys_dept.ancestors    is '祖级列表';
comment on column sys_dept.dept_name    is '部门名称';
comment on column sys_dept.dept_category is '部门类别编码';
comment on column sys_dept.order_num    is '显示顺序';
comment on column sys_dept.leader       is '负责人';
comment on column sys_dept.phone        is '联系电话';
comment on column sys_dept.email        is '邮箱';
comment on column sys_dept.status       is '部门状态（0正常 1停用）';
comment on column sys_dept.del_flag     is '删除标志（0代表存在 1代表删除）';
comment on column sys_dept.create_dept  is '创建部门';
comment on column sys_dept.create_by    is '创建者';
comment on column sys_dept.create_time  is '创建时间';
comment on column sys_dept.update_by    is '更新者';
comment on column sys_dept.update_time  is '更新时间';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------


-- ----------------------------
create table sys_user (
  user_id           number(20)      not null,
  dept_id           number(20)      default null,
  user_name         varchar2(40)    not null,
  nick_name         varchar2(40)    not null,
  user_type         varchar2(10)    default 'sys_user',
  email             varchar2(50)    default '',
  phone_number      varchar2(11)    default '',
  gender            char(1)         default '0',
  avatar            number(20)      default null,
  password          varchar2(100)   default '',
  status            char(1)         default '0',
  del_flag          char(1)         default '0',
  login_ip          varchar2(128)   default '',
  login_date        date,
  create_dept       number(20)      default null,
  create_by         number(20)      default null,
  create_time       date,
  update_by         number(20)      default null,
  update_time       date,
  remark            varchar2(500)   default ''
);

alter table sys_user add constraint pk_sys_user primary key (user_id);

create index idx_sys_user_dept_id on sys_user (dept_id);
create index idx_sys_user_create_by on sys_user (create_by);
create index idx_sys_user_user_name on sys_user (user_name);
create index idx_sys_user_phone on sys_user (phone_number);

comment on table  sys_user              is '用户信息表';
comment on column sys_user.user_id      is '用户ID';
comment on column sys_user.dept_id      is '部门ID';
comment on column sys_user.user_name    is '用户账号';
comment on column sys_user.nick_name    is '用户昵称';
comment on column sys_user.user_type    is '用户类型（sys_user系统用户）';
comment on column sys_user.email        is '用户邮箱';
comment on column sys_user.phone_number is '手机号码';
comment on column sys_user.gender       is '用户性别（0男 1女 2未知）';
comment on column sys_user.avatar       is '头像路径';
comment on column sys_user.password     is '密码';
comment on column sys_user.status       is '账号状态（0正常 1停用）';
comment on column sys_user.del_flag     is '删除标志（0代表存在 1代表删除）';
comment on column sys_user.login_ip     is '最后登录IP';
comment on column sys_user.login_date   is '最后登录时间';
comment on column sys_user.create_dept  is '创建部门';
comment on column sys_user.create_by    is '创建者';
comment on column sys_user.create_time  is '创建时间';
comment on column sys_user.update_by    is '更新者';
comment on column sys_user.update_time  is '更新时间';
comment on column sys_user.remark       is '备注';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
create table sys_post (
  post_id           number(20)      not null,
  dept_id           number(20)      not null,
  post_code         varchar2(64)    not null,
  post_category     varchar2(64)    default null,
  post_name         varchar2(50)    not null,
  post_sort         number(4)       not null,
  status            char(1)         not null,
  del_flag          char(1)         default '0',
  create_dept       number(20)      default null,
  create_by         number(20)      default null,
  create_time       date,
  update_by         number(20)      default null,
  update_time       date,
  remark            varchar2(500)
);

alter table sys_post add constraint pk_sys_post primary key (post_id);

create index idx_sys_post_dept_id on sys_post (dept_id);

comment on table  sys_post              is '岗位信息表';
comment on column sys_post.post_id      is '岗位ID';
comment on column sys_post.dept_id      is '部门id';
comment on column sys_post.post_code    is '岗位编码';
comment on column sys_post.post_category is '岗位类别编码';
comment on column sys_post.post_name    is '岗位名称';
comment on column sys_post.post_sort    is '显示顺序';
comment on column sys_post.status       is '状态（0正常 1停用）';
comment on column sys_post.del_flag     is '删除标志（0代表存在 1代表删除）';
comment on column sys_post.create_dept  is '创建部门';
comment on column sys_post.create_by    is '创建者';
comment on column sys_post.create_time  is '创建时间';
comment on column sys_post.update_by    is '更新者';
comment on column sys_post.update_time  is '更新时间';
comment on column sys_post.remark       is '备注';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
create table sys_role (
  role_id              number(20)      not null,
  role_name            varchar2(30)    not null,
  role_key             varchar2(100)   not null,
  role_sort            number(4)       not null,
  data_scope           char(1)         default '1',
  menu_check_strictly  number(1)       default 1,
  dept_check_strictly  number(1)       default 1,
  status               char(1)         not null,
  del_flag             char(1)         default '0',
  create_dept          number(20)      default null,
  create_by            number(20)      default null,
  create_time          date,
  update_by            number(20)      default null,
  update_time          date,
  remark               varchar2(500)   default null
);

alter table sys_role add constraint pk_sys_role primary key (role_id);

create index idx_sys_role_create_dept on sys_role (create_dept);
create index idx_sys_role_create_by on sys_role (create_by);

comment on table  sys_role                       is '角色信息表';
comment on column sys_role.role_id               is '角色ID';
comment on column sys_role.role_name             is '角色名称';
comment on column sys_role.role_key              is '角色权限字符串';
comment on column sys_role.role_sort             is '显示顺序';
comment on column sys_role.data_scope            is '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）';
comment on column sys_role.menu_check_strictly   is '菜单树选择项是否关联显示';
comment on column sys_role.dept_check_strictly   is '部门树选择项是否关联显示';
comment on column sys_role.status                is '角色状态（0正常 1停用）';
comment on column sys_role.del_flag              is '删除标志（0代表存在 1代表删除）';
comment on column sys_role.create_dept           is '创建部门';
comment on column sys_role.create_by             is '创建者';
comment on column sys_role.create_time           is '创建时间';
comment on column sys_role.update_by             is '更新者';
comment on column sys_role.update_time           is '更新时间';
comment on column sys_role.remark                is '备注';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
create table sys_menu (
  menu_id           number(20)      not null,
  menu_name         varchar2(50)    not null,
  parent_id         number(20)      default 0,
  order_num         number(4)       default 0,
  path              varchar2(200)    default '',
  component         varchar2(255)    default null,
  query_param       varchar2(255)    default null,
  is_frame          char(1)         default 'N',
  is_cache          char(1)         default 'Y',
  menu_type         char(1)         default '',
  visible           char(1)         default 0,
  status            char(1)         default 0,
  perms             varchar2(100)   default null,
  icon              varchar2(100)   default '#',
  active_menu       varchar2(255)   default '',
  ext               varchar2(2000)  default '',
  create_dept       number(20)      default null,
  create_by         number(20)      default null,
  create_time       date,
  update_by         number(20)      default null,
  update_time       date ,
  remark            varchar2(500)   default ''
);

alter table sys_menu add constraint pk_sys_menu primary key (menu_id);

comment on table  sys_menu              is '菜单权限表';
comment on column sys_menu.menu_id      is '菜单ID';
comment on column sys_menu.menu_name    is '菜单名称';
comment on column sys_menu.parent_id    is '父菜单ID';
comment on column sys_menu.order_num    is '显示顺序';
comment on column sys_menu.path         is '请求地址';
comment on column sys_menu.component    is '路由地址';
comment on column sys_menu.query_param  is '路由参数';
comment on column sys_menu.is_frame     is '是否为外链（Y是 N否）';
comment on column sys_menu.is_cache     is '是否缓存（Y缓存 N不缓存）';
comment on column sys_menu.menu_type    is '菜单类型（M目录 C菜单 F按钮）';
comment on column sys_menu.visible      is '显示状态（0显示 1隐藏）';
comment on column sys_menu.status       is '菜单状态（0正常 1停用）';
comment on column sys_menu.perms        is '权限标识';
comment on column sys_menu.icon         is '菜单图标';
comment on column sys_menu.create_dept  is '创建部门';
comment on column sys_menu.create_by    is '创建者';
comment on column sys_menu.create_time  is '创建时间';
comment on column sys_menu.update_by    is '更新者';
comment on column sys_menu.update_time  is '更新时间';
comment on column sys_menu.active_menu  is '激活菜单路径';
comment on column sys_menu.ext          is '扩展字段';
comment on column sys_menu.remark       is '备注';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
-- 一级菜单
create table sys_user_role (
  user_id  number(20)  not null,
  role_id  number(20)  not null
);

alter table sys_user_role add constraint pk_sys_user_role primary key (user_id, role_id);

create index idx_sys_user_role_rid on sys_user_role (role_id);

comment on table  sys_user_role              is '用户和角色关联表';
comment on column sys_user_role.user_id      is '用户ID';
comment on column sys_user_role.role_id      is '角色ID';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
create table sys_role_menu (
  role_id  number(20)  not null,
  menu_id  number(20)  not null
);

alter table sys_role_menu add constraint pk_sys_role_menu primary key (role_id, menu_id);

comment on table  sys_role_menu              is '角色和菜单关联表';
comment on column sys_role_menu.role_id      is '角色ID';
comment on column sys_role_menu.menu_id      is '菜单ID';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------
-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
create table sys_role_dept (
  role_id  number(20)  not null,
  dept_id  number(20)  not null
);

alter table sys_role_dept add constraint pk_sys_role_dept primary key (role_id, dept_id);

comment on table  sys_role_dept              is '角色和部门关联表';
comment on column sys_role_dept.role_id      is '角色ID';
comment on column sys_role_dept.dept_id      is '部门ID';


-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
create table sys_user_post (
  user_id number(20)  not null,
  post_id number(20)  not null
);

alter table sys_user_post add constraint pk_sys_user_post primary key (user_id, post_id);

comment on table  sys_user_post              is '用户与岗位关联表';
comment on column sys_user_post.user_id      is '用户ID';
comment on column sys_user_post.post_id      is '岗位ID';

-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
create table sys_oper_log (
  oper_id           number(20)      not null,
  title             varchar2(50)    default '',
  business_type     number(2)       default 0,
  method            varchar2(100)   default '',
  request_method    varchar2(10)     default '',
  operator_type     number(1)       default 0,
  oper_name         varchar2(50)    default '',
  user_id           number(20)      default null,
  dept_id           number(20)      default null,
  dept_name         varchar2(50)    default '',
  client_key        varchar2(32)    default '',
  device_type       varchar2(32)    default '',
  browser           varchar2(50)    default '',
  os                varchar2(50)    default '',
  oper_url          varchar2(255)   default '',
  oper_ip           varchar2(128)   default '',
  oper_location     varchar2(255)   default '',
  oper_param        varchar2(4000)  default '',
  json_result       varchar2(4000)  default '',
  status            number(1)       default 0,
  error_msg         varchar2(4000)  default '',
  oper_time         date,
  cost_time         number(20)      default 0
);

alter table sys_oper_log add constraint pk_sys_oper_log primary key (oper_id);
create index idx_sys_oper_log_bt on sys_oper_log (business_type);
create index idx_sys_oper_log_uid on sys_oper_log (user_id);
create index idx_sys_oper_log_s on sys_oper_log (status);
create index idx_sys_oper_log_ot on sys_oper_log (oper_time);

comment on table  sys_oper_log                is '操作日志记录';
comment on column sys_oper_log.oper_id        is '日志主键';
comment on column sys_oper_log.title          is '模块标题';
comment on column sys_oper_log.business_type  is '业务类型（0其它 1新增 2修改 3删除）';
comment on column sys_oper_log.method         is '方法名称';
comment on column sys_oper_log.request_method is '请求方式';
comment on column sys_oper_log.operator_type  is '操作类别（0其它 1后台用户 2手机端用户）';
comment on column sys_oper_log.oper_name      is '操作人员';
comment on column sys_oper_log.user_id        is '操作用户ID';
comment on column sys_oper_log.dept_id        is '操作部门ID';
comment on column sys_oper_log.dept_name      is '部门名称';
comment on column sys_oper_log.client_key     is '客户端';
comment on column sys_oper_log.device_type    is '设备类型';
comment on column sys_oper_log.browser        is '浏览器类型';
comment on column sys_oper_log.os             is '操作系统';
comment on column sys_oper_log.oper_url       is '请求URL';
comment on column sys_oper_log.oper_ip        is '主机地址';
comment on column sys_oper_log.oper_location  is '操作地点';
comment on column sys_oper_log.oper_param     is '请求参数';
comment on column sys_oper_log.json_result    is '返回参数';
comment on column sys_oper_log.status         is '操作状态（0正常 1异常）';
comment on column sys_oper_log.error_msg      is '错误消息';
comment on column sys_oper_log.oper_time      is '操作时间';
comment on column sys_oper_log.cost_time      is '消耗时间';


-- ----------------------------
-- 11、字典类型表
-- ----------------------------
create table sys_dict_type (
  dict_id           number(20)      not null,
  dict_name         varchar2(100)   default '',
  dict_type         varchar2(100)   default '',
  create_dept       number(20)      default null,
  create_by         number(20)      default null,
  create_time       date,
  update_by         number(20)      default null,
  update_time       date,
  remark            varchar2(500)   default null
);

alter table sys_dict_type add constraint pk_sys_dict_type primary key (dict_id);
create unique index sys_dict_type_index1 on sys_dict_type (dict_type);

comment on table  sys_dict_type               is '字典类型表';
comment on column sys_dict_type.dict_id       is '字典主键';
comment on column sys_dict_type.dict_name     is '字典名称';
comment on column sys_dict_type.dict_type     is '字典类型';
comment on column sys_dict_type.create_dept   is '创建部门';
comment on column sys_dict_type.create_by     is '创建者';
comment on column sys_dict_type.create_time   is '创建时间';
comment on column sys_dict_type.update_by     is '更新者';
comment on column sys_dict_type.update_time   is '更新时间';
comment on column sys_dict_type.remark        is '备注';

create table sys_dict_data (
  dict_code        number(20)      not null,
  dict_sort        number(4)       default 0,
  dict_label       varchar2(100)   default '',
  dict_value       varchar2(100)   default '',
  dict_type        varchar2(100)   default '',
  css_class        varchar2(100)   default null,
  list_class       varchar2(100)   default null,
  is_default       char(1)         default 'N',
  create_dept      number(20)      default null,
  create_by        number(20)      default null,
  create_time      date,
  update_by        number(20)      default null,
  update_time      date,
  remark           varchar2(500)   default null
);

alter table sys_dict_data add constraint pk_sys_dict_data primary key (dict_code);

create index idx_sys_dict_data_type on sys_dict_data (dict_type);

comment on table  sys_dict_data               is '字典数据表';
comment on column sys_dict_data.dict_code     is '字典主键';
comment on column sys_dict_data.dict_sort     is '字典排序';
comment on column sys_dict_data.dict_label    is '字典标签';
comment on column sys_dict_data.dict_value    is '字典键值';
comment on column sys_dict_data.dict_type     is '字典类型';
comment on column sys_dict_data.css_class     is '样式属性（其他样式扩展）';
comment on column sys_dict_data.list_class    is '表格回显样式';
comment on column sys_dict_data.is_default    is '是否默认（Y是 N否）';
comment on column sys_dict_data.create_dept   is '创建部门';
comment on column sys_dict_data.create_by     is '创建者';
comment on column sys_dict_data.create_time   is '创建时间';
comment on column sys_dict_data.update_by     is '更新者';
comment on column sys_dict_data.update_time   is '更新时间';
comment on column sys_dict_data.remark        is '备注';

create table sys_config (
  config_id         number(20)     not null,
  config_name       varchar2(100)  default '',
  config_key        varchar2(100)  default '',
  config_value      varchar2(100)  default '',
  config_type       char(1)        default 'N',
  create_dept       number(20)     default null,
  create_by         number(20)     default null,
  create_time       date,
  update_by         number(20)     default null,
  update_time       date,
  remark            varchar2(500)  default null
);
alter table sys_config add constraint pk_sys_config primary key (config_id);

comment on table  sys_config               is '参数配置表';
comment on column sys_config.config_id     is '参数主键';
comment on column sys_config.config_name   is '参数名称';
comment on column sys_config.config_key    is '参数键名';
comment on column sys_config.config_value  is '参数键值';
comment on column sys_config.config_type   is '系统内置（Y是 N否）';
comment on column sys_config.create_dept   is '创建部门';
comment on column sys_config.create_by     is '创建者';
comment on column sys_config.create_time   is '创建时间';
comment on column sys_config.update_by     is '更新者';
comment on column sys_config.update_time   is '更新时间';
comment on column sys_config.remark        is '备注';

create table sys_login_info (
  info_id         number(20)     not null,
  user_name       varchar2(50)   default '',
  client_key      varchar2(32)   default '',
  device_type     varchar2(32)   default '',
  ipaddr          varchar2(128)  default '',
  login_location  varchar2(255)  default '',
  browser         varchar2(50)   default '',
  os              varchar2(50)   default '',
  status          char(1)        default '0',
  msg             varchar2(255)  default '',
  login_time      date
);

alter table sys_login_info add constraint pk_sys_login_info primary key (info_id);
create index idx_sys_login_info_s on sys_login_info (status);
create index idx_sys_login_info_lt on sys_login_info (login_time);

comment on table  sys_login_info               is '系统访问记录';
comment on column sys_login_info.info_id       is '访问ID';
comment on column sys_login_info.user_name     is '登录账号';
comment on column sys_login_info.client_key    is '客户端';
comment on column sys_login_info.device_type   is '设备类型';
comment on column sys_login_info.ipaddr        is '登录IP地址';
comment on column sys_login_info.login_location is '登录地点';
comment on column sys_login_info.browser       is '浏览器类型';
comment on column sys_login_info.os            is '操作系统';
comment on column sys_login_info.status        is '登录状态（0正常 1异常）';
comment on column sys_login_info.msg           is '提示消息';
comment on column sys_login_info.login_time    is '访问时间';


-- ----------------------------
-- 17、通知公告表
-- ----------------------------
create table sys_notice (
  notice_id         number(20)      not null,
  notice_title      varchar2(50)    not null,
  notice_type       char(1)         not null,
  notice_content    clob            default null,
  status            char(1)         default '0',
  create_dept       number(20)      default null,
  create_by         number(20)      default null,
  create_time       date,
  update_by         number(20)      default null,
  update_time       date,
  remark            varchar2(255)   default null
);

alter table sys_notice add constraint pk_sys_notice primary key (notice_id);

comment on table  sys_notice                   is '通知公告表';
comment on column sys_notice.notice_id         is '公告主键';
comment on column sys_notice.notice_title      is '公告标题';
comment on column sys_notice.notice_type       is '公告类型（1通知 2公告）';
comment on column sys_notice.notice_content    is '公告内容';
comment on column sys_notice.status            is '公告状态（0正常 1关闭）';
comment on column sys_notice.create_dept       is '创建部门';
comment on column sys_notice.create_by         is '创建者';
comment on column sys_notice.create_time       is '创建时间';
comment on column sys_notice.update_by         is '更新者';
comment on column sys_notice.update_time       is '更新时间';
comment on column sys_notice.remark            is '备注';

-- ----------------------------
-- 初始化-公告信息表数据
-- ----------------------------
create table sys_message (
  message_id       number(20)      not null,
  category         varchar2(20)    not null,
  type             varchar2(20)    not null,
  source           varchar2(20)    not null,
  title            varchar2(100)   default '',
  message          varchar2(500)   default '',
  content          clob            default null,
  data_json        clob            default null,
  path             varchar2(500)   default null,
  send_user_ids    varchar2(2000)  default '0' not null,
  create_dept      number(20)      default null,
  create_by        number(20)      default null,
  create_time      date,
  update_by        number(20)      default null,
  update_time      date
);

alter table sys_message add constraint pk_sys_message primary key (message_id);

create index idx_sys_message_category_time on sys_message(category, create_time);

comment on table  sys_message                  is '消息记录表';
comment on column sys_message.message_id       is '消息ID';
comment on column sys_message.category         is '消息分组(system/notice/workflow)';
comment on column sys_message.type             is '消息类型';
comment on column sys_message.source           is '消息来源';
comment on column sys_message.title            is '标题';
comment on column sys_message.message          is '摘要消息';
comment on column sys_message.content          is '详细内容';
comment on column sys_message.data_json        is '扩展数据JSON';
comment on column sys_message.path             is '前端跳转路径';
comment on column sys_message.send_user_ids    is '目标用户ID串，0表示全局';
comment on column sys_message.create_dept      is '创建部门';
comment on column sys_message.create_by        is '创建者';
comment on column sys_message.create_time      is '创建时间';
comment on column sys_message.update_by        is '更新者';
comment on column sys_message.update_time      is '更新时间';


-- ----------------------------
-- 19、代码生成业务表
-- ----------------------------
create table gen_table (
  table_id          number(20)       not null,
  data_name         varchar2(200)    default '',
  table_name        varchar2(200)    default '',
  table_comment     varchar2(500)    default '',
  class_name        varchar2(100)    default '',
  tpl_category      varchar2(200)    default 'crud',
  frontend_type     varchar2(50)     default 'vue',
  package_name      varchar2(100),
  module_name       varchar2(30),
  business_name     varchar2(30),
  function_name     varchar2(50),
  function_author   varchar2(50),
  gen_type          char(1)          default '0',
  gen_path          varchar2(200)    default '/',
  options           varchar2(1000),
  create_dept       number(20)       default null,
  create_by         number(20)       default null,
  create_time       date,
  update_by         number(20)       default null,
  update_time       date,
  remark            varchar2(500)    default null
);

alter table gen_table add constraint pk_gen_table primary key (table_id);

comment on table  gen_table                   is '代码生成业务表';
comment on column gen_table.table_id          is '编号';
comment on column gen_table.data_name         is '数据源名称';
comment on column gen_table.table_name        is '表名称';
comment on column gen_table.table_comment     is '表描述';
comment on column gen_table.class_name        is '实体类名称';
comment on column gen_table.tpl_category      is '使用的模板（crud单表操作 tree树表操作）';
comment on column gen_table.frontend_type     is '前端模板类型，对应 vm 下的模板目录';
comment on column gen_table.package_name      is '生成包路径';
comment on column gen_table.module_name       is '生成模块名';
comment on column gen_table.business_name     is '生成业务名';
comment on column gen_table.function_name     is '生成功能名';
comment on column gen_table.function_author   is '生成功能作者';
comment on column gen_table.gen_type          is '生成代码方式（0zip压缩包 1自定义路径）';
comment on column gen_table.gen_path          is '生成路径（不填默认项目路径）';
comment on column gen_table.options           is '其它生成选项';
comment on column gen_table.create_dept       is '创建部门';
comment on column gen_table.create_by         is '创建者';
comment on column gen_table.create_time       is '创建时间';
comment on column gen_table.update_by         is '更新者';
comment on column gen_table.update_time       is '更新时间';
comment on column gen_table.remark            is '备注';


-- ----------------------------
-- 20、代码生成业务表字段
-- ----------------------------
create table gen_table_column (
  column_id         number(20)      not null,
  table_id          number(20),
  column_name       varchar2(200),
  column_comment    varchar2(500),
  column_type       varchar2(100),
  java_type         varchar2(500),
  java_field        varchar2(200),
  is_pk             char(1),
  is_increment      char(1),
  is_required       char(1),
  is_insert         char(1),
  is_edit           char(1),
  is_list           char(1),
  is_query          char(1),
  query_type        varchar2(200)    default 'EQ',
  html_type         varchar2(200),
  dict_type         varchar2(200)    default '',
  sort              number(4),
  create_dept       number(20)       default null,
  create_by         number(20)       default null,
  create_time       date ,
  update_by         number(20)       default null,
  update_time       date
);

alter table gen_table_column add constraint pk_gen_table_column primary key (column_id);

comment on table  gen_table_column                is '代码生成业务表字段';
comment on column gen_table_column.column_id      is '编号';
comment on column gen_table_column.table_id       is '归属表编号';
comment on column gen_table_column.column_name    is '列名称';
comment on column gen_table_column.column_comment is '列描述';
comment on column gen_table_column.column_type    is '列类型';
comment on column gen_table_column.java_type      is 'JAVA类型';
comment on column gen_table_column.java_field     is 'JAVA字段名';
comment on column gen_table_column.is_pk          is '是否主键（1是）';
comment on column gen_table_column.is_increment   is '是否自增（1是）';
comment on column gen_table_column.is_required    is '是否必填（1是）';
comment on column gen_table_column.is_insert      is '是否为插入字段（1是）';
comment on column gen_table_column.is_edit        is '是否编辑字段（1是）';
comment on column gen_table_column.is_list        is '是否列表字段（1是）';
comment on column gen_table_column.is_query       is '是否查询字段（1是）';
comment on column gen_table_column.query_type     is '查询方式（等于、不等于、大于、小于、范围）';
comment on column gen_table_column.html_type      is '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
comment on column gen_table_column.dict_type      is '字典类型';
comment on column gen_table_column.sort           is '排序';
comment on column gen_table_column.create_dept    is '创建部门';
comment on column gen_table_column.create_by      is '创建者';
comment on column gen_table_column.create_time    is '创建时间';
comment on column gen_table_column.update_by      is '更新者';
comment on column gen_table_column.update_time    is '更新时间';


-- ----------------------------
-- OSS对象存储表
-- ----------------------------
create table sys_oss (
  oss_id          number(20)     not null,
  file_name       varchar2(255)  not null,
  original_name   varchar2(255)  not null,
  file_suffix     varchar2(10)   not null,
  url             varchar2(500)  not null,
  service         varchar2(20)   default 'minio' not null,
  ext1            varchar2(500)  default '',
  create_dept     number(20)     default null,
  create_by       number(20)     default null,
  create_time     date,
  update_by       number(20)     default null,
  update_time     date
);

alter table sys_oss add constraint pk_sys_oss primary key (oss_id);

comment on table sys_oss                    is 'OSS对象存储表';
comment on column sys_oss.oss_id            is '对象存储主键';
comment on column sys_oss.file_name         is '文件名';
comment on column sys_oss.original_name     is '原名';
comment on column sys_oss.file_suffix       is '文件后缀名';
comment on column sys_oss.url               is 'URL地址';
comment on column sys_oss.service           is '服务商';
comment on column sys_oss.ext1              is '扩展字段';
comment on column sys_oss.create_dept       is '创建部门';
comment on column sys_oss.create_time       is '创建时间';
comment on column sys_oss.create_by         is '上传者';
comment on column sys_oss.update_time       is '更新时间';
comment on column sys_oss.update_by         is '更新者';


-- ----------------------------
-- OSS对象存储动态配置表
-- ----------------------------
create table sys_oss_config (
  oss_config_id   number(20)     not null,
  config_key      varchar2(20)   not null,
  access_key      varchar2(255)  default '',
  secret_key      varchar2(255)  default '',
  bucket_name     varchar2(255)  default '',
  prefix          varchar2(255)  default '',
  endpoint        varchar2(255)  default '',
  domain_url      varchar2(255)  default '',
  is_https        char(1)        default 'N',
  region          varchar2(255)  default '',
  access_policy   char(1)        default '1' not null,
  status          char(1)        default 'N',
  ext1            varchar2(255)  default '',
  remark          varchar2(500)  default null,
  create_dept     number(20)     default null,
  create_by       number(20)     default null,
  create_time     date,
  update_by       number(20)     default null,
  update_time     date
);

alter table sys_oss_config add constraint pk_sys_oss_config primary key (oss_config_id);

comment on table sys_oss_config                 is '对象存储配置表';
comment on column sys_oss_config.oss_config_id  is '主键';
comment on column sys_oss_config.config_key     is '配置key';
comment on column sys_oss_config.access_key     is 'accesskey';
comment on column sys_oss_config.secret_key     is '秘钥';
comment on column sys_oss_config.bucket_name    is '桶名称';
comment on column sys_oss_config.prefix         is '前缀';
comment on column sys_oss_config.endpoint       is '访问站点';
comment on column sys_oss_config.domain_url     is '自定义域名';
comment on column sys_oss_config.is_https       is '是否https（Y=是,N=否）';
comment on column sys_oss_config.region         is '域';
comment on column sys_oss_config.access_policy  is '桶权限类型(0=private 1=public 2=custom)';
comment on column sys_oss_config.status         is '是否默认（Y=是,N=否）';
comment on column sys_oss_config.ext1           is '扩展字段';
comment on column sys_oss_config.remark         is '备注';
comment on column sys_oss_config.create_dept    is '创建部门';
comment on column sys_oss_config.create_by      is '创建者';
comment on column sys_oss_config.create_time    is '创建时间';
comment on column sys_oss_config.update_by      is '更新者';
comment on column sys_oss_config.update_time    is '更新时间';

create table sys_client (
    id                  number(20)     not null,
    client_id           varchar2(64)   default null,
    client_key          varchar2(32)   default null,
    client_secret       varchar2(255)  default null,
    grant_type          varchar2(255)  default null,
    device_type         varchar2(32)   default null,
    access_path         varchar2(2000) default null,
    ip_whitelist        varchar2(1000) default null,
    active_timeout      number(11)     default 1800,
    timeout             number(11)     default 604800,
    status              char(1)        default '0',
    del_flag            char(1)        default '0',
    create_dept         number(20)     default null,
    create_by           number(20)     default null,
    create_time         date,
    update_by           number(20)     default null,
    update_time         date
);

alter table sys_client add constraint pk_sys_client primary key (id);

comment on table sys_client                         is '系统授权表';
comment on column sys_client.id                     is '主键';
comment on column sys_client.client_id              is '客户端id';
comment on column sys_client.client_key             is '客户端key';
comment on column sys_client.client_secret          is '客户端秘钥';
comment on column sys_client.grant_type             is '授权类型';
comment on column sys_client.device_type            is '设备类型';
comment on column sys_client.access_path            is '允许访问路径';
comment on column sys_client.ip_whitelist           is 'IP白名单';
comment on column sys_client.active_timeout         is 'token活跃超时时间';
comment on column sys_client.timeout                is 'token固定超时';
comment on column sys_client.status                 is '状态（0正常 1停用）';
comment on column sys_client.del_flag               is '删除标志（0代表存在 1代表删除）';
comment on column sys_client.create_dept            is '创建部门';
comment on column sys_client.create_by              is '创建者';
comment on column sys_client.create_time            is '创建时间';
comment on column sys_client.update_by              is '更新者';
comment on column sys_client.update_time            is '更新时间';

create or replace trigger login_trg
after logon on database
begin
execute immediate 'alter session set nls_date_format=''YYYY-MM-DD HH24:MI:SS''';
end;
