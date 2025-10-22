# mysql8.0-employees
FROM mysql/mysql-server:8.0.27-aarch64

LABEL maintainer "ac0mz"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY initdb /initdb
RUN cat /initdb/test_db/employees.sql \
        /initdb/test_db/objects.sql \
        /initdb/users.sql \
    > /initdb/test_db/initdb.sql
