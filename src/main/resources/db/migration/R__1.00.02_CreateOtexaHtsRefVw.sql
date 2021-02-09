CREATE OR ALTER VIEW [dbo].[OTEXA_HTS_REF_VW]
AS
    SELECT hts_cat.[HTS], hts_cat.[CAT_ID], CONCAT(hts_cat.[HTS], ' - ', hts.[DESCRIPTION]) as 'LONG_HTS'
    FROM [dbo].[OTEXA_HTS_REF] hts
    FULL OUTER JOIN [dbo].[OTEXA_HTS_CAT_REF] hts_cat
    ON hts.HTS = hts_cat.HTS
GO