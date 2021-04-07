DROP VIEW IF EXISTS [dbo].[OTEXA_MONTHLY_TQ_VW]
GO

CREATE VIEW [dbo].[OTEXA_MONTHLY_TQ_VW]
AS
    SELECT details.[YR] as 'Year'
        , details.[MON] as 'Month'
        , details.[QUANTITY] as 'Quantity'
        , details.[VAL] as 'Value'
        , details.[COUNTRY] as 'Country'
        , details.[CAT] as 'Category ID'
        , category.[CAT_DESCRIPTION] as 'Category Description'
        , hts.[LONG_HTS] as 'HTS'
        , chapter.[LONG_CHAPTER] as 'Chapter'
    FROM OTEXA_MONTHLY_TQ details
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
