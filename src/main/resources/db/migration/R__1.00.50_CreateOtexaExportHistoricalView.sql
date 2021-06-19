DROP VIEW IF EXISTS [dbo].[OTEXA_EXPORTS_HISTORICAL_VW]
GO

CREATE OR ALTER VIEW [dbo].[OTEXA_EXPORTS_HISTORICAL_VW]
AS
SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , group_table.[LONG_GROUP] as 'Group'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
    , details.[REPORT_YEAR] as 'Report Year'
    , details.[REPORT_MONTH] as 'Report Month'
FROM [dbo].[OTEXA_EXPORTS_HISTORICAL] details
LEFT JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'EXPORT'
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'EXPORT'
LEFT JOIN [dbo].[OTEXA_GROUP_REF_VW] group_table
    ON details.[GROUP] = group_table.[GROUP_ID]

WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO
