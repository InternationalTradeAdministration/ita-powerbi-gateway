DROP TABLE IF EXISTS [dbo].[OTEXA_COUNTRY_REF]
CREATE TABLE [dbo].[OTEXA_COUNTRY_REF] (
   [CTRY_ID] INT IDENTITY,
   [CTRY_DESCRIPTION] VARCHAR(255),
   [SOURCE] VARCHAR(255)
)

DROP TABLE IF EXISTS [dbo].[OTEXA_EXE_HTS]
GO

DROP TABLE IF EXISTS [dbo].[OTEXA_ANNUAL]
GO

CREATE TABLE [dbo].[OTEXA_ANNUAL](
	[Country] [varchar](255) NULL,
	[CAT_ID] [int] NULL,
	[HTS] [varchar](25) NULL,
	[SYEF] [decimal](5, 2) NULL,
	[HEADER_ID] [varchar](25) NULL,
	[VAL] [decimal](30, 10) NULL
)
GO

DROP TABLE IF EXISTS [dbo].[OTEXA_ANNUAL_FOOTWEAR]
GO

CREATE TABLE [dbo].[OTEXA_ANNUAL_FOOTWEAR](
	[Country] [varchar](255) NULL,
	[CAT_ID] [int] NULL,
	[HTS] [varchar](25) NULL,
    [Quantity] [varchar](25) NULL,
	[HEADER_ID] [varchar](25) NULL,
	[VAL] [decimal](30, 10) NULL,
	[DATA_TYPE] [varchar](25)
)
GO

DROP VIEW IF EXISTS [dbo].[OTEXA_EXE_HTS_VW2]
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
    , CASE WHEN hdr.[HEADER_TYPE] = 'UNITS' THEN details.[VAL] / details.[SYEF] ELSE details.[VAL] END AS 'DATA_VALUE'
    , hdr.[HEADER_TYPE] as 'DATA_TYPE'
FROM [dbo].[OTEXA_ANNUAL] details
INNER JOIN [dbo].[OTEXA_HEADER_REF] hdr
    ON details.[HEADER_ID] = hdr.[HEADER_ID]
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
    AND hts.CAT_ID = details.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
GO

DROP PROCEDURE IF EXISTS sp_OTEXA_UPDATE_COUNTRY
GO

CREATE PROCEDURE sp_OTEXA_UPDATE_COUNTRY
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
END
GO

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
INNER JOIN [dbo].[OTEXA_CATEGORY_REF_VW] category
    ON details.[CAT_ID] = category.[CAT_ID]
INNER JOIN [dbo].[OTEXA_HTS_REF_VW] hts
    ON hts.[HTS] = details.[HTS]
INNER JOIN [dbo].[OTEXA_HTS_CHAPTER_REF_VW] chapter
    ON hts.[HTS] = chapter.[HTS]
    AND hts.[CAT_ID] = chapter.[CAT_ID]
GO

DROP TABLE IF EXISTS [dbo].[OTEXA_CATEGORY_REF]
GO

CREATE TABLE [dbo].[OTEXA_CATEGORY_REF](
    [CAT_ID] [int] NULL,
    [CAT_DESCRIPTION] [varchar](255) NULL,
    [SOURCE] [varchar](255)
)
GO

exec sp_refreshview @viewname='OTEXA_CATEGORY_REF_VW'
