DROP VIEW IF EXISTS [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
GO

CREATE VIEW [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
AS
    SELECT mapping.CAT_ID
        , mapping.HTS
        , CONCAT(mapping.[HTS], ' - ', hts.[DESCRIPTION]) as 'LONG_HTS'
        , mapping.CHAPTER
        , CONCAT(mapping.[CHAPTER], ' - ', c.[CHAPTER_DESCRIPTION]) as 'LONG_CHAPTER'
        , mapping.SOURCE
    FROM OTEXA_HTS_CHAPTER_REF mapping
    LEFT OUTER JOIN OTEXA_CHAPTER_REF c
        ON mapping.CHAPTER = c.CHAPTER
    LEFT OUTER JOIN [OTEXA_HTS_REF] hts
        ON mapping.HTS = hts.HTS
        AND mapping.CAT_ID = hts.CAT_ID
    WHERE mapping.HTS is NOT NULL
GO
