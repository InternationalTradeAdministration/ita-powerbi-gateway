IF SCHEMA_ID('express_leads') IS NULL
    EXEC('CREATE SCHEMA [express_leads] AUTHORIZATION [dbo]')
