USE $(DB_NAME);
-- mssql use LOGIN for authentication, and the USER for Database-level authorization
DECLARE @APP_USER NVARCHAR(128) = '$(APP_USER)';
DECLARE @APP_PASSWORD NVARCHAR(128) = '$(APP_PASSWORD)';
DECLARE @DB_NAME NVARCHAR(128) = '$(DB_NAME)';
DECLARE @SQL NVARCHAR(MAX);


IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = @APP_USER)
BEGIN
    PRINT 'Login already exists';
END
ELSE
BEGIN
    EXEC('USE '+ @DB_NAME)

    SET @SQL = 'CREATE LOGIN ' + @APP_USER + ' WITH PASSWORD = ''' + @APP_PASSWORD + ''';';
    EXEC(@SQL);

    SET @SQL = 'CREATE USER ' + @APP_USER + ' FOR LOGIN ' + @APP_USER + ';';
    EXEC(@SQL);

    SET @SQL = 'ALTER ROLE db_owner ADD MEMBER ' + @APP_USER + ';';
    EXEC(@SQL);

    SET @SQL = 'GRANT CONNECT TO ' + @APP_USER + ';';
    EXEC(@SQL);

    PRINT '$(APP_USER) created for $(DB_NAME)...';
END

