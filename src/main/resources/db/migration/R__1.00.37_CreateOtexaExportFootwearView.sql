CREATE OR ALTER VIEW [dbo].[OTEXA_EXPORT_FOOTWEAR_VW]
AS
SELECT details.[Country]
    , details.[CAT_ID] as 'Category ID'
    , details.[CAT_DESC] as 'Category Description'
    , details.[SCHEDULE_B] as 'Schedule B'
    , details.[SCHEDULE_B_DESC] as 'Schedule B Description'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , details.[HEADER_ID] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , details.[DATA_TYPE]
    , details.[Quantity] as 'Quantity'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_EXPORT_FOOTWEAR] details

FULL OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON details.[SCHEDULE_B] = chapter.[HTS]
    AND details.[CAT_ID] = chapter.[CAT_ID]

WHERE details.[HEADER_ID] IS NOT NULL
GO
