IF SCHEMA_ID('express_leads_reader') IS NULL
    EXEC('CREATE SCHEMA [express_leads_reader] AUTHORIZATION [dbo]')
