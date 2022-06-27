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

CREATE OR ALTER VIEW [dbo].[OTEXA_TRADE_BALANCE_YEARS_VW]
AS
SELECT DISTINCT [HEADER_ID]
    , [Trade Flow]
    , [Trade Year]
FROM (
    SELECT [HEADER_ID]
        , CASE WHEN CHARINDEX('YTD',[Header_ID]) > 0
          THEN SUBSTRING([Header_ID],11,7)
          ELSE SUBSTRING([Header_ID],1,7)
          END AS "Trade Flow"
        , CASE WHEN CHARINDEX('YTD',[Header_ID]) > 0
          THEN SUBSTRING([Header_ID],1,8)
          ELSE SUBSTRING([Header_ID],9,4)
          END AS "Trade Year"
    FROM [dbo].[OTEXA_TRADE_BALANCE]
) x
GO