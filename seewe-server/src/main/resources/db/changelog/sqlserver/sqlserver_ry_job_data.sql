--liquibase formatted sql
--changeset seewe:20260805-02-sqlserver-job-data endDelimiter:GO
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:1 SELECT COUNT(*) FROM DATABASECHANGELOG WHERE ID = '20260805-02-sqlserver-job-table' AND AUTHOR = 'seewe' AND EXECTYPE = 'EXECUTED'

INSERT INTO sj_namespace(name, unique_id, description, deleted, create_dt, update_dt) VALUES (N'Development', N'dev', N'', 0, getdate(), getdate())
GO
INSERT INTO sj_namespace(name, unique_id, description, deleted, create_dt, update_dt) VALUES (N'Production', N'prod', N'', 0, getdate(), getdate())
GO

-- sj_group_config
INSERT INTO sj_group_config(namespace_id, group_name, description, token, group_status, version, group_partition, id_generator_mode, init_scene, create_dt, update_dt) VALUES (N'dev', N'ruoyi_group', N'', N'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', N'1', N'1', N'0', N'1', N'1', getdate(), getdate())
GO
INSERT INTO sj_group_config(namespace_id, group_name, description, token, group_status, version, group_partition, id_generator_mode, init_scene, create_dt, update_dt) VALUES (N'prod', N'ruoyi_group', N'', N'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', N'1', N'1', N'0', N'1', N'1', getdate(), getdate())
GO

-- sj_notify_config
INSERT INTO sj_system_user (username, password, role)
VALUES (N'admin', N'465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac', 2)
GO

INSERT INTO sys_menu VALUES (1761400000000000120, N'任务调度中心', 1761400000000000002, 5, N'snailjob', N'monitor/snailjob/index', N'', N'N', N'Y', N'C', N'0', N'0', N'monitor:snailjob:list', N'gridicons:scheduled', N'', N'', 1761000000000000103, 1761100000000000001, getdate(), NULL, NULL, N'SnailJob控制台菜单')
GO

-- sj_system_user_permission
INSERT INTO sj_job (namespace_id, biz_id, group_name, job_name, args_str, args_type, next_trigger_at, job_status, task_type, route_key, executor_type, executor_info, trigger_type, trigger_interval, block_strategy,executor_timeout, max_retry_times, parallel_num, retry_interval, bucket_index, resident, notify_ids, owner_id, labels, description, ext_attrs, deleted, create_dt, update_dt) VALUES (N'dev', N'demo-job', N'ruoyi_group', N'demo-job', null, 1, 1710344035622, 1, 1, 4, 1, N'testJobExecutor', 2, N'60', 1, 60, 3, 1, 1, 116, 0, N'', 1, N'', N'', N'', 0, getdate(), getdate())
GO

-- sj_job_log_message
