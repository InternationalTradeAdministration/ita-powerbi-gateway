DROP VIEW IF EXISTS [dbo].[OTEXA_MONTHLY_IMPORTS_VW]
GO

CREATE VIEW [dbo].[OTEXA_MONTHLY_IMPORTS_VW]
AS
    SELECT details.[YR] as 'Year'
        , details.[MON] as 'Month'
        , details.[VALUE] as 'Value'
        , details.[M2] as 'M2'
        , details.[QUANTITY] as 'Quantity'
        , details.[UOM] as 'UOM'
        , country.[CTRY_DESCRIPTION] as 'Country'
        , details.[CTRYNUM]
        , details.[CAT] as 'Category ID'
        , category.[CAT_DESCRIPTION] as 'Category Description'
        , category.[LONG_CATEGORY] as 'Category'
        , hts.[LONG_HTS] as 'HTS'
        , chapter.[LONG_CHAPTER] as 'Chapter'
    FROM OTEXA_MONTHLY_IMPORTS details
        LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
        ON details.[CTRYNUM] = country.[CTRY_NUMBER]
        AND country.[SOURCE] = 'ANNUAL'
    LEFT OUTER JOIN [dbo].[otexa_category_ref_vw] category
        ON details.[CAT] = category.[CAT_ID]
        AND category.[SOURCE] = 'ANNUAL'
    LEFT OUTER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
        ON details.[HTS] = hts.[HTS]
        AND details.[CAT] = hts.[CAT_ID]
    LEFT OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
        ON details.[HTS] = chapter.[HTS]
        AND details.[CAT] = chapter.[CAT_ID]
        AND chapter.[SOURCE] = 'ANNUAL'
GO
