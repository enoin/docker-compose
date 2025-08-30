#!/bin/sh

MSSQL_SA_USER=SA

echo run sqlservr

sh /init/init.sh & /opt/mssql/bin/sqlservr
