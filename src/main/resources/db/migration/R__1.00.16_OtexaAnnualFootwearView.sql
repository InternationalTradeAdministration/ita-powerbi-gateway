DROP VIEW IF EXISTS [dbo].[OTEXA_ANNUAL_FOOTWEAR_VW]
GO

CREATE VIEW [dbo].[OTEXA_ANNUAL_FOOTWEAR_VW]
AS
SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , details.[HEADER_ID] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , details.[DATA_TYPE]
FROM [dbo].[OTEXA_ANNUAL_FOOTWEAR] details
FULL OUTER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
FULL OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
WHERE details.[HEADER_ID] IS NOT NULL
GO
