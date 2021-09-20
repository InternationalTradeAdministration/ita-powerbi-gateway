DROP VIEW IF EXISTS [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS_VW]
GO

CREATE VIEW [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS_VW]
AS
    SELECT details.[YR] as 'Year'
        , details.[MON] as 'Month'
        , details.[VALUE] as 'Value'
        , details.[QUANTITY] as 'Quantity'
        , details.[UOM] as 'UOM'
        , country.[CTRY_DESCRIPTION] as 'Country'
        , details.[CTRYNUM]
        , details.[CAT] as 'Category ID'
        , category.[CAT_DESCRIPTION] as 'Category Description'
        , category.[LONG_CATEGORY] as 'Category'
        , CONCAT(hts.[HTS], ' - ', hts.[HTS Description]) as 'HTS'
        , chapter.[LONG_CHAPTER] as 'Chapter'
    FROM OTEXA_MONTHLY_FOOTWEAR_IMPORTS details
        LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
        ON details.[CTRYNUM] = country.[CTRY_NUMBER]
        AND country.[SOURCE] = 'ANNUAL_FOOTWEAR'
    LEFT OUTER JOIN [dbo].[otexa_category_ref_vw] category
        ON details.[CAT] = category.[CAT_ID]
        AND category.[SOURCE] = 'ANNUAL_FOOTWEAR'
    LEFT OUTER JOIN [dbo].[OTEXA_FOOTWEAR_HTS_LOOKUP] hts
        ON details.[HTS] = hts.[HTS]
        AND details.[CAT] = hts.[Category]
    LEFT OUTER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
        ON details.[HTS] = chapter.[HTS]
        AND details.[CAT] = chapter.[CAT_ID]
        AND chapter.[SOURCE] = 'ANNUAL_FOOTWEAR'
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_MONTHLY_FOOTWEAR_EXPORTS_VW]
GO

CREATE VIEW [dbo].[OTEXA_MONTHLY_FOOTWEAR_EXPORTS_VW]
AS
    SELECT details.[YR] as 'Year'
        , details.[MON] as 'Month'
        , details.[VALUE] as 'Value'
        , details.[QUANTITY] as 'Quantity'
        , details.[UOM] as 'UOM'
        , country.[CTRY_DESCRIPTION] as 'Country'
        , details.[CTRYNUM]
        , details.[CAT] as 'Category ID'
        , category.[CAT_DESCRIPTION] as 'Category Description'
        , category.[LONG_CATEGORY] as 'Category'
        , chapter.[SCHEDULE_B] as 'Schedule B ID'
        , chapter.[LONG_SCHEDB] as 'Schedule B'
        , chapter.[LONG_CHAPTER] as 'Chapter'
    FROM OTEXA_MONTHLY_FOOTWEAR_EXPORTS details
        LEFT OUTER JOIN [dbo].[OTEXA_COUNTRY_REF_VW] country
        ON details.[CTRYNUM] = country.[CTRY_NUMBER]
        AND country.[SOURCE] = 'EXPORT_FOOTWEAR'
    LEFT OUTER JOIN [dbo].[otexa_category_ref_vw] category
        ON details.[CAT] = category.[CAT_ID]
        AND category.[SOURCE] = 'EXPORT_FOOTWEAR'
    LEFT OUTER JOIN [dbo].[OTEXA_SCHEDULEB_CHAPTER_REF_VW] chapter
        ON details.[SCHEDB] = chapter.[SCHEDULE_B]
        AND details.[CAT] = chapter.[CAT_ID]
        AND chapter.[SOURCE] = 'EXPORT_FOOTWEAR'
GO
