CREATE OR ALTER VIEW [dbo].[OTEXA_ANNUAL_VW]
AS
SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'ANNUAL'
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
    AND category.[SOURCE] = 'ANNUAL'
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
    AND chapter.[SOURCE] = 'ANNUAL'
WHERE hdr.[HEADER_DESCRIPTION] IS NOT NULL

UNION ALL

SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , CASE 
        WHEN hdr.[HEADER_DESCRIPTION] = 'Current Month' THEN details.[VAL]
        ELSE details.[VAL] / details.[SYEF]
        END as 'DATA_VALUE'
    , 'UNITS' as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'ANNUAL'
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
    AND category.[SOURCE] = 'ANNUAL'
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
    AND chapter.[SOURCE] = 'ANNUAL'
WHERE hdr.[HEADER_TYPE] = 'SME'
AND hdr.[HEADER_DESCRIPTION] IS NOT NULL

UNION ALL

SELECT details.[CTRYNUM]
    , country.[CTRY_DESCRIPTION] as 'Country'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] * details.[SYEF] AS 'DATA_VALUE'
    , 'SME' as 'DATA_TYPE'
    , details.[UOM] as 'Unit of Measure'
    , details.[M2] as 'M2'
    , details.[DOLLAR_SIGN] as 'Dollar Sign'
    , details.[REPORT_MONTH] as 'Report Month'
    , details.[REPORT_YEAR] as 'Report Year'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
    AND hdr.[SOURCE] = 'ANNUAL'
LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
    ON details.[CTRYNUM] = country.[CTRY_NUMBER]
    AND country.[SOURCE] = 'ANNUAL'
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
    AND category.[SOURCE] = 'ANNUAL'
FULL OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
FULL OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
    AND chapter.[SOURCE] = 'ANNUAL'
WHERE hdr.[HEADER_TYPE] = 'UNITS'
AND hdr.[HEADER_DESCRIPTION] IS NOT NULL

GO
