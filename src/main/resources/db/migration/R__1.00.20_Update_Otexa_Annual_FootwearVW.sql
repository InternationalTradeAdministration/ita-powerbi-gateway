DROP VIEW IF EXISTS [dbo].[OTEXA_ANNUAL_FOOTWEAR_VW]
GO

CREATE VIEW [dbo].[OTEXA_ANNUAL_FOOTWEAR_VW]
AS
SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , details.[HEADER_ID] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , details.[DATA_TYPE]
    , details.[Quantity] as 'Quantity'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_ANNUAL_FOOTWEAR] details

LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'ANNUAL_FOOTWEAR'

FULL OUTER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
    AND category.[SOURCE] = 'ANNUAL_FOOTWEAR'

FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]

FULL OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
    AND chapter.[SOURCE] = 'ANNUAL_FOOTWEAR'

WHERE details.[HEADER_ID] IS NOT NULL
GO
