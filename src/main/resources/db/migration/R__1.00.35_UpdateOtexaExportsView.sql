DROP VIEW IF EXISTS [dbo].[OTEXA_EXPORTS_VW]
GO

CREATE OR ALTER VIEW [dbo].[OTEXA_EXPORTS_VW]
AS
SELECT details.[COUNTRY] as 'Country'
    , group_table.[LONG_GROUP] as 'Group'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , schedb.[LONG_SCHEDB] as 'Schedule B'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
    , details.[REPORT_YEAR] as 'Report Year'
    , details.[REPORT_MONTH] as 'Report Month'
FROM [dbo].[OTEXA_EXPORTS] details
INNER JOIN [dbo].[OTEXA_HEADER_EXPORTS_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_GROUP_REF_VW] group_table
    ON details.[GROUP] = group_table.[GROUP_ID]
FULL OUTER JOIN [dbo].[OTEXA_SCHEDULEB_REF_VW] schedb
    ON schedb.[SCHEDULE_B] = details.[SCHEDB]
    AND schedb.[GROUP_ID] = details.[GROUP]
FULL OUTER JOIN [dbo].[OTEXA_SCHEDULEB_CHAPTER_REF_VW] chapter
    ON schedb.[SCHEDULE_B] = chapter.[SCHEDULE_B]
    AND schedb.[GROUP_ID] = chapter.[GROUP_ID]

WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO
