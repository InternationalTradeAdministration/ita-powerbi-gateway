DROP VIEW IF EXISTS [dbo].[OTEXA_CATEGORY_REF_VW]
GO

CREATE VIEW [OTEXA_CATEGORY_REF_VW]
AS
    SELECT *, CONCAT([CAT_ID], ' - ', [CAT_DESCRIPTION]) as 'LONG_CATEGORY'
    FROM [dbo].[OTEXA_CATEGORY_REF]
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_HTS_REF_VW]
GO

CREATE VIEW [OTEXA_HTS_REF_VW]
AS
    SELECT *, CONCAT([HTS], ' - ', [DESCRIPTION]) as 'LONG_HTS'
    FROM [dbo].[OTEXA_HTS_REF]
GO

IF EXISTS (SELECT * FROM sys.tables WHERE [type] = 'U' and [name] = 'OTEXA_HTS_CHAPTER__REF')
BEGIN
    EXEC sp_rename 'dbo.OTEXA_HTS_CHAPTER__REF', 'OTEXA_HTS_CHAPTER_REF'
END
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_HTS_CHAPTER_REF_VW]
GO

CREATE VIEW [OTEXA_HTS_CHAPTER_REF_VW]
AS
    SELECT *, CONCAT([CHAPTER], ' - ', [CHAPTER_DESCRIPTION]) as 'LONG_CHAPTER' FROM OTEXA_HTS_CHAPTER_REF
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_EXE_HTS_VW2]
GO

CREATE VIEW [dbo].[OTEXA_EXE_HTS_VW2]
AS
SELECT country.[CTRY_DESCRIPTION] as 'Country'
    , category.[LONG_CATEGORY] as 'Category'
    , hts.[LONG_HTS] as 'HTS'
    , chapter.[LONG_CHAPTER] as 'Chapter'
    , hdr.[HEADER_DESCRIPTION] as 'DATA_KEY'
    , CASE WHEN hdr.[HEADER_TYPE] = 'UNITS' THEN details.[VAL] / details.[SYEF] ELSE details.[VAL] END AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
FROM [dbo].[OTEXA_EXE_HTS] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
INNER JOIN [dbo].[OTEXA_COUNTRY_REF] country
    ON details.[CTRY_ID] = country.[CTRY_ID]
INNER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.CAT_ID = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
GO
