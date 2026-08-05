# Liquibase 数据库变更

应用启动时会执行唯一的 `db.changelog-master.yaml`。默认只启用 MySQL 初始化 SQL；需要切换数据库时，在该文件中取消对应数据库块的注释，并注释 MySQL 块。

- `mysql`：核心、任务调度、工作流和 AI 的 `*_table.sql`、`*_data.sql`。
- `postgresql`：核心、任务调度、工作流和 AI 的 `*_table.sql`、`*_data.sql`。
- `oracle`：核心、任务调度和工作流的 `*_table.sql`、`*_data.sql`。
- `sqlserver`：核心、任务调度和工作流的 `*_table.sql`、`*_data.sql`，使用 `GO` 作为语句分隔符。

已有数据库检测到对应的基础表时会将初始化结构和数据变更标记为已执行，不会重复建表或导入初始化数据。全新数据库会先执行 `*_table.sql`，再执行 `*_data.sql`，并创建 `DATABASECHANGELOG`、`DATABASECHANGELOGLOCK` 和项目表。

后续结构或数据变更请新增文件到当前启用数据库的 `changes` 目录，不要修改已执行的初始化 SQL。文件使用 Liquibase formatted SQL，例如：

```sql
--liquibase formatted sql
--changeset seewe:20260805-01-add-user-index dbms:mysql
CREATE INDEX idx_sys_user_status ON sys_user(status);
```

文件名按 `VyyyyMMddHHmm__description.sql` 命名。当前启用数据库目录由 `includeAll` 自动加载其中的 formatted SQL；每个 changeset 必须写明对应的 `dbms`，避免执行错误方言。
