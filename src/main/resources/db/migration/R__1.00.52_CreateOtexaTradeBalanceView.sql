DROP VIEW IF EXISTS [dbo].[OTEXA_TRADE_BALANCE_VW]
GO

CREATE VIEW [dbo].[OTEXA_TRADE_BALANCE_VW]
AS
    SELECT details.[YR] as 'Year'
    , details.[MON] as 'Month'
    , country.[CTRY_DESCRIPTION] as 'Country'
    , details.[CTRYNUM]
    , details.[GGRP] as 'Aggregate Group'
    , details.[HEADER_ID] as 'Header ID'
    , details.[VALUE] as 'Value'
FROM [dbo].[OTEXA_TRADE_BALANCE] details
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'ANNUAL'
GO
