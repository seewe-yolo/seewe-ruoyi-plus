--liquibase formatted sql
--changeset seewe:20260805-02-oracle-job-data
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:1 SELECT COUNT(*) FROM DATABASECHANGELOG WHERE ID = '20260805-02-oracle-job-table' AND AUTHOR = 'seewe' AND EXECTYPE = 'EXECUTED'

INSERT INTO sj_namespace(name, unique_id, description, deleted, create_dt, update_dt) VALUES ('Development', 'dev', '', 0, sysdate, sysdate);
INSERT INTO sj_namespace(name, unique_id, description, deleted, create_dt, update_dt) VALUES ('Production', 'prod', '', 0, sysdate, sysdate);

-- sj_group_config
INSERT INTO sj_group_config (namespace_id, group_name, description, token, group_status, version, group_partition, id_generator_mode, init_scene, create_dt, update_dt) VALUES ('dev', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1,  sysdate, sysdate);
INSERT INTO sj_group_config (namespace_id, group_name, description, token, group_status, version, group_partition, id_generator_mode, init_scene, create_dt, update_dt) VALUES ('prod', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1,  sysdate, sysdate);

-- sj_notify_config
INSERT INTO sj_system_user (username, password, role)
VALUES ('admin', '465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac', 2);

INSERT INTO sys_menu VALUES (1761400000000000120, '任务调度中心', 1761400000000000002, 5, 'snailjob', 'monitor/snailjob/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:snailjob:list', 'gridicons:scheduled', '', '', 1761000000000000103, 1761100000000000001, sysdate, NULL, NULL, 'SnailJob控制台菜单');

-- sj_system_user_permission
INSERT INTO sj_job(namespace_id, biz_id, group_name, job_name, args_str, args_type, next_trigger_at, job_status, task_type, route_key, executor_type, executor_info, trigger_type, trigger_interval, block_strategy,executor_timeout, max_retry_times, parallel_num, retry_interval, bucket_index, resident, notify_ids, owner_id, labels, description, ext_attrs, deleted, create_dt, update_dt) VALUES ('dev', 'demo-job', 'ruoyi_group', 'demo-job', NULL, 1, 1710344035622, 1, 1, 4, 1, 'testJobExecutor', 2, '60', 1, 60, 3, 1, 1, 116, 0, '', 1, '','', '', 0, sysdate, sysdate);

-- sj_job_log_message
