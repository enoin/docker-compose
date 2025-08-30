DECLARE @DB_NAME NVARCHAR(100) = '$(DB_NAME)';
PRINT 'Create $(DB_NAME) Database...';

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = @DB_NAME)
BEGIN
    EXEC('CREATE DATABASE '+ @DB_NAME + ' COLLATE Hungarian_Technical_CI_AS')
    EXEC('ALTER DATABASE '+ @DB_NAME + ' SET READ_COMMITTED_SNAPSHOT ON')
    PRINT 'Database [' + @DB_NAME + '] has been created.';
END
ELSE
BEGIN
    PRINT 'Database [$(DB_NAME)] already exists';
END

