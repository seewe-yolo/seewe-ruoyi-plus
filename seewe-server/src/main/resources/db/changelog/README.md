# Liquibase 数据库变更

应用启动时会执行唯一的 `db.changelog-master.yaml`。默认只启用 MySQL 初始化 SQL；需要切换数据库时，在该文件中取消对应数据库块的注释，并注释 MySQL 块。

- `mysql`：核心、任务调度、工作流和 AI 的 `*_table.sql`、`*_data.sql`。
- `postgresql`：核心、任务调度、工作流和 AI 的 `*_table.sql`、`*_data.sql`。

已有数据库检测到对应的基础表时会将初始化结构和数据变更标记为已执行，不会重复建表或导入初始化数据。全新数据库会先执行 `*_table.sql`，再执行 `*_data.sql`，并创建 `DATABASECHANGELOG`、`DATABASECHANGELOGLOCK` 和项目表。

后续 insert / update 等数据变更：直接追加到所属模块 SQL 文件中对应表的语句之后（与表初始化语句同处一个 changeset 内），不新增 changeset 块、不新增文件。仅当变更依赖其他模块的执行顺序（如适配另一模块写入的数据）或需要独立 precondition 保护时，才在文件末尾新增 changeset。changeset 使用 Liquibase formatted SQL，例如：

```sql
--changeset seewe:20260913-02-add-user-index
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'sys_user' AND index_name = 'idx_sys_user_status'
CREATE INDEX idx_sys_user_status ON sys_user(status);
```

- changeset id 按 `yyyyMMdd-序号-描述` 命名，作者固定 `seewe`；
- 涉及多种数据库的变更需在对应数据库的模块 SQL 中各写一份，并写明 `dbms`（如 `dbms:mysql`），避免执行错误方言；
- 幂等性由 precondition 保证，确保清库重跑或已有库增量执行都安全。
