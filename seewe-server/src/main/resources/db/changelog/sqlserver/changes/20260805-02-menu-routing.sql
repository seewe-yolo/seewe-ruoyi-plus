--liquibase formatted sql
--changeset seewe:20260805-02-sqlserver-menu-routing

UPDATE sys_menu SET component = 'Layout', icon = 'carbon:cloud-service-management', menu_name = 'route.system' WHERE menu_id = 1761400000000000001;
UPDATE sys_menu SET component = 'Layout', icon = 'stash:dashboard', menu_name = 'route.monitor' WHERE menu_id = 1761400000000000002;
UPDATE sys_menu SET component = 'Layout', icon = 'tabler:tools', menu_name = 'route.tool' WHERE menu_id = 1761400000000000003;
UPDATE sys_menu SET component = 'Layout', icon = 'tabler:logs', menu_name = 'menu.system_log' WHERE menu_id = 1761400000000000108;
UPDATE sys_menu SET icon = 'ic:round-manage-accounts', menu_name = 'route.system_user' WHERE menu_id = 1761400000000000100;
UPDATE sys_menu SET icon = 'carbon:user-role', menu_name = 'route.system_role' WHERE menu_id = 1761400000000000101;
UPDATE sys_menu SET icon = 'material-symbols:route', menu_name = 'route.system_menu' WHERE menu_id = 1761400000000000102;
UPDATE sys_menu SET icon = 'mingcute:department-line', menu_name = 'route.system_dept' WHERE menu_id = 1761400000000000103;
UPDATE sys_menu SET icon = 'hugeicons:permanent-job', menu_name = 'route.system_post' WHERE menu_id = 1761400000000000104;
UPDATE sys_menu SET icon = 'qlementine-icons:dictionary-16', menu_name = 'route.system_dict' WHERE menu_id = 1761400000000000105;
UPDATE sys_menu SET icon = 'carbon:parameter', menu_name = 'route.system_config' WHERE menu_id = 1761400000000000106;
UPDATE sys_menu SET icon = 'solar:chat-line-outline', menu_name = 'route.system_notice' WHERE menu_id = 1761400000000000107;
UPDATE sys_menu SET icon = 'majesticons:status-online-line', menu_name = 'route.monitor_online' WHERE menu_id = 1761400000000000109;
UPDATE sys_menu SET icon = 'simple-icons:redis', menu_name = 'route.monitor_cache' WHERE menu_id = 1761400000000000113;
UPDATE sys_menu SET icon = 'material-symbols:code-blocks-outline', menu_name = 'route.tool_gen' WHERE menu_id = 1761400000000000115;
UPDATE sys_menu SET icon = 'material-symbols:attach-file', menu_name = 'route.system_oss' WHERE menu_id = 1761400000000000118;
UPDATE sys_menu SET icon = 'tabler:brain' WHERE menu_id = 1761400000000000121;
UPDATE sys_menu SET icon = 'tabler:device-imac-cog', menu_name = 'route.system_client' WHERE menu_id = 1761400000000000123;
UPDATE sys_menu SET icon = 'carbon:operations-record', menu_name = 'route.monitor_operlog' WHERE menu_id = 1761400000000000500;
UPDATE sys_menu SET icon = 'tabler:login-2', menu_name = 'route.monitor_logininfo' WHERE menu_id = 1761400000000000501;
UPDATE sys_menu SET path = 'oss/config', component = 'system/oss-config/index', icon = 'hugeicons:configuration-01', menu_name = 'route.system_oss-config' WHERE menu_id = 1761400000000000133;

UPDATE sys_menu SET status = '0', component = 'Layout', icon = 'hugeicons:flow-square' WHERE menu_id = 1761400000000011616;
UPDATE sys_menu SET status = '0', component = 'Layout', icon = 'fluent:notepad-person-16-regular' WHERE menu_id = 1761400000000011618;
UPDATE sys_menu SET path = 'task-waiting', component = 'workflow/task/task-waiting/index', icon = 'ri:todo-line' WHERE menu_id = 1761400000000011619;
UPDATE sys_menu SET path = 'process-definition', component = 'workflow/process-definition/index', icon = 'weui:setting-outlined' WHERE menu_id = 1761400000000011620;
UPDATE sys_menu SET path = 'process-instance', component = 'workflow/process-instance/index', icon = 'ri:instance-line' WHERE menu_id = 1761400000000011621;
UPDATE sys_menu SET icon = 'carbon:category' WHERE menu_id = 1761400000000011622;
UPDATE sys_menu SET path = 'my-document', component = 'workflow/task/my-document/index', icon = 'hugeicons:start-up-02' WHERE menu_id = 1761400000000011629;
UPDATE sys_menu SET component = 'Layout', icon = 'lucide:monitor-cog' WHERE menu_id = 1761400000000011630;
UPDATE sys_menu SET path = 'all-task-waiting', component = 'workflow/task/all-task-waiting/index', icon = 'ri:todo-line' WHERE menu_id = 1761400000000011631;
UPDATE sys_menu SET path = 'task-finish', component = 'workflow/task/task-finish/index', icon = 'hugeicons:task-done-01' WHERE menu_id = 1761400000000011632;
UPDATE sys_menu SET path = 'task-copy', component = 'workflow/task/task-copy/index', icon = 'mynaui:copy' WHERE menu_id = 1761400000000011633;
UPDATE sys_menu SET parent_id = 1761400000000011616, path = 'leave', component = 'workflow/leave/index', icon = 'ic:twotone-time-to-leave', status = '0' WHERE menu_id = 1761400000000011638;
UPDATE sys_menu SET path = 'design', component = 'workflow/design/index', icon = 'material-symbols:design-services-outline', status = '0' WHERE menu_id = 1761400000000011700;
UPDATE sys_menu SET status = '1' WHERE menu_id = 1761400000000011701;
UPDATE sys_menu SET icon = 'material-symbols:regular-expression-rounded' WHERE menu_id = 1761400000000011801;
