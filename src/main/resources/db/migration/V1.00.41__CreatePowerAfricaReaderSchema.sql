DECLARE @schema_name AS nvarchar(128)
DECLARE @sql_string AS nvarchar(4000)

SET @schema_name = 'power_africa_reader'

IF SCHEMA_ID(@schema_name) IS NULL
    BEGIN
        SET @sql_string = FORMATMESSAGE('
CREATE SCHEMA [%s] AUTHORIZATION [dbo]
', @schema_name)

        EXEC (@sql_string)
    END
