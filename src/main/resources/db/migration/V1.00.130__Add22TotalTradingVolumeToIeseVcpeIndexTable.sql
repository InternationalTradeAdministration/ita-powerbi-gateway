IF NOT EXISTS(SELECT 1
              FROM sys.columns
              WHERE Name = N'22_Total_Trading_Volume'
                AND Object_ID = OBJECT_ID(N'dbo.IESE_VCPE_INDEX'))
    BEGIN
        ALTER TABLE [dbo].[IESE_VCPE_INDEX]
            ADD [22_Total_Trading_Volume] NUMERIC(5, 1)
    END
