IF NOT EXISTS(SELECT 1
              FROM sys.columns
              WHERE Name = N'ID'
                AND Object_ID = OBJECT_ID(N'dbo.OTEXA_MONTHLY_FOOTWEAR_IMPORTS'))
    BEGIN
        TRUNCATE TABLE [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS]
        ALTER TABLE [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS]
            ADD [ID] bigint IDENTITY PRIMARY KEY NOT NULL
    END
