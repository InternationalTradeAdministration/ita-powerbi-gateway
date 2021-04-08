CREATE OR ALTER VIEW [dbo].[OTEXA_EXPORT_FOOTWEAR_VW]
AS
SELECT details.[Country]
    , details.[CAT_ID] as 'Category ID'
    , details.[CAT_DESC] as 'Category Description'
    , chapter.[SCHEDULE_B] as 'Schedule B ID'
    , chapter.[LONG_SCHEDB] as 'Schedule B'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , details.[HEADER_ID] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , details.[DATA_TYPE]
    , details.[Quantity] as 'Quantity'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_EXPORT_FOOTWEAR] details

LEFT OUTER JOIN [dbo].[OTEXA_SCHEDULEB_CHAPTER_REF_VW] chapter
    ON details.[SCHEDULE_B] = chapter.[SCHEDULE_B]
    AND details.[CAT_ID] = chapter.[CAT_ID]
    AND chapter.[SOURCE] = 'EXPORT_FOOTWEAR'

LEFT OUTER JOIN [dbo].[otexa_category_ref_vw] category
    ON details.[CAT_ID] = category.[CAT_ID]
    AND category.[SOURCE] = 'EXPORT_FOOTWEAR'

WHERE details.[HEADER_ID] IS NOT NULL
GO
