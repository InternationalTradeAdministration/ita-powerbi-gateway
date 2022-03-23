IF SCHEMA_ID('imau_gatm') IS NULL
    EXEC ('CREATE SCHEMA [imau_gatm] AUTHORIZATION [dbo]')
