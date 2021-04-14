DROP VIEW IF EXISTS [dbo].[OTEXA_EXPORTS_VW]
GO

CREATE OR ALTER VIEW [dbo].[OTEXA_EXPORTS_VW]
AS
SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , group_table.[LONG_GROUP] as 'Group'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , chapter.[LONG_SCHEDB] as 'Schedule B'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
    , details.[REPORT_YEAR] as 'Report Year'
    , details.[REPORT_MONTH] as 'Report Month'
FROM [dbo].[OTEXA_EXPORTS] details
LEFT JOIN [dbo].[OTEXA_HEADER_EXPORTS_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'EXPORT'
LEFT JOIN [dbo].[OTEXA_GROUP_REF_VW] group_table
    ON details.[GROUP] = group_table.[GROUP_ID]
LEFT OUTER JOIN [dbo].[OTEXA_SCHEDULEB_CHAPTER_REF_VW] chapter
    ON details.[SCHEDB] = chapter.[SCHEDULE_B]
    AND details.[GROUP] = chapter.[GROUP_ID]
    AND chapter.[SOURCE] = 'EXPORT'

WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO
