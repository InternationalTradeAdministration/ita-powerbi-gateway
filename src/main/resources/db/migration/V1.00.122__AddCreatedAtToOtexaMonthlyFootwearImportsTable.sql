IF NOT EXISTS(SELECT 1
              FROM sys.columns
              WHERE Name = N'CREATED_AT'
                AND Object_ID = OBJECT_ID(N'dbo.OTEXA_MONTHLY_FOOTWEAR_IMPORTS'))
    BEGIN
        ALTER TABLE [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS]
            ADD [CREATED_AT] datetime NOT NULL
        CREATE NONCLUSTERED INDEX OTEXA_MONTHLY_FOOTWEAR_IMPORTS_ON_CREATED_AT
            ON [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS] (CREATED_AT)
    END
