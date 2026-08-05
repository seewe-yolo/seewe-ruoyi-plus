package org.dromara.test;

import liquibase.changelog.ChangeLogParameters;
import liquibase.changelog.DatabaseChangeLog;
import liquibase.parser.ChangeLogParserFactory;
import liquibase.resource.ClassLoaderResourceAccessor;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class LiquibaseChangelogTest {

    @Test
    void shouldLoadAllInitialChangelogs() throws Exception {
        try (ClassLoaderResourceAccessor resourceAccessor = new ClassLoaderResourceAccessor()) {
            DatabaseChangeLog changeLog = ChangeLogParserFactory.getInstance()
                .getParser("db/changelog/db.changelog-master.yaml", resourceAccessor)
                .parse("db/changelog/db.changelog-master.yaml", new ChangeLogParameters(), resourceAccessor);

            assertEquals(6, changeLog.getChangeSets().size());
        }
    }

    @Test
    void shouldLoadAllDatabaseInitialSqlChangelogs() throws Exception {
        List<String> changelogPaths = List.of(
            "db/changelog/mysql/ry_vue_table.sql",
            "db/changelog/mysql/ry_vue_data.sql",
            "db/changelog/mysql/ry_job_table.sql",
            "db/changelog/mysql/ry_job_data.sql",
            "db/changelog/mysql/ry_workflow_table.sql",
            "db/changelog/mysql/ry_workflow_data.sql",
            "db/changelog/mysql/ry_ai_table.sql",
            "db/changelog/mysql/ry_ai_data.sql",
            "db/changelog/postgresql/postgres_ry_vue_table.sql",
            "db/changelog/postgresql/postgres_ry_vue_data.sql",
            "db/changelog/postgresql/postgres_ry_job_table.sql",
            "db/changelog/postgresql/postgres_ry_job_data.sql",
            "db/changelog/postgresql/postgres_ry_workflow_table.sql",
            "db/changelog/postgresql/postgres_ry_workflow_data.sql",
            "db/changelog/postgresql/postgres_ry_ai_table.sql",
            "db/changelog/postgresql/postgres_ry_ai_data.sql",
            "db/changelog/oracle/oracle_ry_vue_table.sql",
            "db/changelog/oracle/oracle_ry_vue_data.sql",
            "db/changelog/oracle/oracle_ry_job_table.sql",
            "db/changelog/oracle/oracle_ry_job_data.sql",
            "db/changelog/oracle/oracle_ry_workflow_table.sql",
            "db/changelog/oracle/oracle_ry_workflow_data.sql",
            "db/changelog/sqlserver/sqlserver_ry_vue_table.sql",
            "db/changelog/sqlserver/sqlserver_ry_vue_data.sql",
            "db/changelog/sqlserver/sqlserver_ry_job_table.sql",
            "db/changelog/sqlserver/sqlserver_ry_job_data.sql",
            "db/changelog/sqlserver/sqlserver_ry_workflow_table.sql",
            "db/changelog/sqlserver/sqlserver_ry_workflow_data.sql"
        );

        try (ClassLoaderResourceAccessor resourceAccessor = new ClassLoaderResourceAccessor()) {
            for (String changelogPath : changelogPaths) {
                DatabaseChangeLog changeLog = ChangeLogParserFactory.getInstance()
                    .getParser(changelogPath, resourceAccessor)
                    .parse(changelogPath, new ChangeLogParameters(), resourceAccessor);

                assertEquals(1, changeLog.getChangeSets().size(), changelogPath);
            }
        }
    }
}
