#!/bin/sh

MSSQL_SA_USER=SA

DB_STATUS=1
while [ ${DB_STATUS} -ne 0 ]; do
    echo wainting for database...
    sleep 1
    sqlcmd -S localhost -U ${MSSQL_SA_USER} -P ${MSSQL_SA_PASSWORD} -d master -Q '' -C
    DB_STATUS=$?
done

echo init [${DB_NAME}] database...

sqlcmd -v DB_NAME=${DB_NAME} -S localhost -U ${MSSQL_SA_USER} -P ${MSSQL_SA_PASSWORD} -d master -i /init/init_db.sql -C
sqlcmd -v DB_NAME=${DB_NAME} -v APP_USER=${APP_USER} -v APP_PASSWORD=${APP_PASSWORD} -S localhost -U ${MSSQL_SA_USER} -P ${MSSQL_SA_PASSWORD} -d master -i /init/init_user.sql -C

