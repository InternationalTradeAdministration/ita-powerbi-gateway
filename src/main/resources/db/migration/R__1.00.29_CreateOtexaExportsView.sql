DROP VIEW IF EXISTS [dbo].[OTEXA_EXPORTS_VW]
GO

CREATE OR ALTER VIEW [dbo].[OTEXA_EXPORTS_VW]
AS
SELECT details.[COUNTRY] as 'Country'
    , details.[REPORT_YEAR] as 'Report Year'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[SCHEDB] as 'Schedule B'
    , details.[GROUP] as 'Group_ID'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
FROM [dbo].[OTEXA_EXPORTS] details
INNER JOIN [dbo].[OTEXA_HEADER_EXPORTS_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO
