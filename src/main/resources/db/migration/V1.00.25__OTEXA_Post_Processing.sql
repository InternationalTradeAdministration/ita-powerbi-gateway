DROP TABLE IF EXISTS [dbo].[OTEXA_CHAPTER_REF]
CREATE TABLE [dbo].[OTEXA_CHAPTER_REF] (
    [CHAPTER] INT,
    [CHAPTER_DESCRIPTION] varchar(255)
)

DROP TABLE IF EXISTS [dbo].[OTEXA_HTS_CHAPTER_REF]
CREATE TABLE [dbo].[OTEXA_HTS_CHAPTER_REF](
	[CHAPTER] [int] NULL,
	[HTS] [varchar](25) NULL,
	[CAT_ID] [int] NULL
)

DROP PROCEDURE IF EXISTS sp_OTEXA_POST_PROCESSING
GO

CREATE PROCEDURE sp_OTEXA_POST_PROCESSING
AS
BEGIN
    DROP TABLE IF EXISTS [dbo].[OTEXA_COUNTRY_REF]
    CREATE TABLE [dbo].[OTEXA_COUNTRY_REF] (
       [CTRY_ID] INT IDENTITY,
       [CTRY_DESCRIPTION] VARCHAR(255),
       [SOURCE] VARCHAR(255)
    )

   INSERT INTO [OTEXA_COUNTRY_REF] ([CTRY_DESCRIPTION], [SOURCE])
   SELECT DISTINCT Country, 'ANNUAL' FROM [dbo].[OTEXA_ANNUAL] UNION ALL
   SELECT DISTINCT Country, 'ANNUAL_FOOTWEAR' FROM [dbo].[OTEXA_ANNUAL_FOOTWEAR]

   TRUNCATE TABLE OTEXA_HTS_CAT_REF
   INSERT INTO OTEXA_HTS_CAT_REF ([HTS], [CAT_ID])
   SELECT DISTINCT [HTS], [CAT_ID] from OTEXA_ANNUAL union
   SELECT DISTINCT [HTS], [CAT_ID] from OTEXA_ANNUAL_FOOTWEAR

   TRUNCATE TABLE [dbo].[OTEXA_HTS_CHAPTER_REF]
   INSERT INTO [dbo].[OTEXA_HTS_CHAPTER_REF] (CAT_ID, CHAPTER, HTS)
   SELECT DISTINCT CAT_ID, SUBSTRING(HTS, 1, 2) as CHAPTER, HTS FROM OTEXA_ANNUAL UNION
   SELECT DISTINCT CAT_ID, SUBSTRING(HTS, 1, 2) as CHAPTER, HTS FROM OTEXA_ANNUAL_FOOTWEAR
END
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
GO

CREATE VIEW [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
AS
    SELECT mapping.CAT_ID
        , mapping.HTS
        , mapping.CHAPTER
        , CONCAT(c.[CHAPTER], ' - ', c.[CHAPTER_DESCRIPTION]) as 'LONG_CHAPTER'
    FROM OTEXA_HTS_CHAPTER_REF mapping
    INNER JOIN OTEXA_CHAPTER_REF c
    ON mapping.CHAPTER = c.CHAPTER
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_ANNUAL_VW]
GO

CREATE VIEW [dbo].[OTEXA_ANNUAL_VW]
AS
SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]

UNION ALL

SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] / details.[SYEF] AS 'DATA_VALUE'
    , 'UNITS' as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
WHERE hdr.[HEADER_TYPE] = 'SME'

UNION ALL

SELECT details.[Country]
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , details.[VAL] * details.[SYEF] AS 'DATA_VALUE'
    , 'SME' as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.[CAT_ID] = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
WHERE hdr.[HEADER_TYPE] = 'UNITS'

GO
