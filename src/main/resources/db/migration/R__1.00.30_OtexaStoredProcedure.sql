CREATE OR ALTER PROCEDURE sp_OTEXA_POST_PROCESSING
AS
BEGIN
   DROP TABLE IF EXISTS [dbo].[OTEXA_COUNTRY_REF]
   CREATE TABLE [dbo].[OTEXA_COUNTRY_REF] (
      [CTRY_NUMBER]  INT NULL,
      [SOURCE]       VARCHAR(255)
   )

   TRUNCATE TABLE OTEXA_COUNTRY_REF
   INSERT INTO [OTEXA_COUNTRY_REF] ([CTRY_NUMBER], [SOURCE])
   SELECT DISTINCT CTRYNUM, 'ANNUAL' FROM [dbo].[OTEXA_ANNUAL] UNION ALL
   SELECT DISTINCT CTRYNUM, 'ANNUAL_FOOTWEAR' FROM [dbo].[OTEXA_ANNUAL_FOOTWEAR] UNION ALL
   SELECT DISTINCT CTRYNUM, 'EXPORT' FROM [dbo].[OTEXA_EXPORTS] UNION ALL
   SELECT DISTINCT CTRYNUM, 'EXPORT_HISTORICAL' FROM [dbo].[OTEXA_EXPORTS_HISTORICAL] UNION ALL
   SELECT DISTINCT [Country Number], 'EXPORT_FOOTWEAR' FROM [dbo].[OTEXA_EXPORT_FOOTWEAR] UNION ALL
   SELECT DISTINCT CTRYNUM, 'MERGED_CAT' FROM [dbo].[OTEXA_MERGED_CAT] UNION ALL
   SELECT DISTINCT CTRYNUM, 'PART_CAT' FROM [dbo].[OTEXA_PART_CAT]

   TRUNCATE TABLE OTEXA_HTS_CAT_REF
   INSERT INTO OTEXA_HTS_CAT_REF ([HTS], [CAT_ID])
   SELECT DISTINCT [HTS], [CAT_ID] from OTEXA_ANNUAL union
   SELECT DISTINCT [HTS], [CAT_ID] from OTEXA_ANNUAL_FOOTWEAR union
   SELECT DISTINCT [SCHEDULE_B], [CAT_ID] FROM OTEXA_EXPORT_FOOTWEAR

   TRUNCATE TABLE [dbo].[OTEXA_HTS_CHAPTER_REF]
   INSERT INTO [dbo].[OTEXA_HTS_CHAPTER_REF] (CAT_ID, CHAPTER, HTS, SOURCE)
   SELECT DISTINCT CAT_ID, SUBSTRING(HTS, 1, 2) as CHAPTER, HTS, 'ANNUAL' FROM OTEXA_ANNUAL UNION
   SELECT DISTINCT CAT_ID, SUBSTRING(HTS, 1, 2) as CHAPTER, HTS, 'ANNUAL_FOOTWEAR' FROM OTEXA_ANNUAL_FOOTWEAR UNION
   SELECT DISTINCT CAT_ID, SUBSTRING(SCHEDULE_B, 1, 2) as CHAPTER, SCHEDULE_B, 'EXPORT_FOOTWEAR' FROM OTEXA_EXPORT_FOOTWEAR
END
GO
