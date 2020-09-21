CREATE OR ALTER VIEW sima_steel_reader.SIMA_LICENSE_VW
AS
SELECT lic.[Country of Origin] as [Country]
    , SUM(lic.[Value]) as [VALUE]
    , SUM(lic.[Volume]) /1000 as [VOLUME]
    , MONTH(lic.[Date of Importation]) as [SMONTH]
    , YEAR(lic.[Date of Importation]) as [SYEAR]
    , ref.[New Product Group] as [Category]
    , CASE WHEN [New Product Group] like '%Stainless%' then 'S' ELSE 'C & A' END as grade2
    , ref.[6 Steel Categories]
    , lic.[HTS Code]
    , MAX(lic.[CREATED_AT]) AS CREATED_AT
FROM dbo.SIMA_LICENSE lic
JOIN dbo.SIMA_STEEL_CONCORDANCE ref
on lic.[HTS Code] = ref.[HTS Code]
GROUP BY lic.[Country of Origin], MONTH(lic.[Date of Importation]), YEAR(lic.[Date of Importation]), ref.[New Product Group], ref.[6 Steel Categories], lic.[HTS Code]
GO

CREATE OR ALTER VIEW sima_steel_reader.SIMA_CENSUS_VW
AS
SELECT RTRIM([CTRY_DESC]) AS Country,
         SUM(cen.[VALUE]) as [VALUE],
         SUM(cen.[NETTON]) as [NETTON],
         SUM(cen.[METRICTON]) AS [QTYMT],
         cen.[STAT_MO]   AS [SMONTH],
         cen.[STAT_YEAR] AS [SYEAR],
         cen.[STEEL_TYPE],
         CASE
           WHEN cen.[STEEL_TYPE] <> 'S' THEN 'C & A'
           ELSE cen.[STEEL_TYPE]
         END         AS grade2,
         CASE
           WHEN cen.[COMM_DESC] LIKE '%..%' THEN Substring(cen.[COMM_DESC], 1, Charindex('..', cen.[COMM_DESC]) - 1)
           ELSE cen.[COMM_DESC]
         END         AS Category,
         ref.[6 Steel Categories],
         cen.id
         ,MAX(cen.[CREATED_AT]) as CREATED_AT
FROM   [dbo].[SIMA_CENSUS] cen
JOIN (Select Distinct [New Product Group], [6 Steel Categories] FROM dbo.SIMA_STEEL_CONCORDANCE) ref
on
CASE WHEN cen.[COMM_DESC] LIKE '%..%' THEN Substring(cen.[COMM_DESC], 1, Charindex('..', cen.[COMM_DESC]) - 1) ELSE cen.[COMM_DESC]
END = [New Product Group]
GROUP BY cen.id, cen.CTRY_DESC, STAT_MO, STAT_YEAR, ref.[New Product Group], ref.[6 Steel Categories], cen.COMM_DESC, cen.STEEL_TYPE
GO

CREATE OR ALTER VIEW sima_steel_reader.SIMA_STEEL_IMPORT_RPT_VW
AS
SELECT [Country], [6 Steel Categories], [Category], [QTYMT] as [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'census' AS [SOURCE], CREATED_AT FROM sima_steel_reader.SIMA_CENSUS_VW UNION ALL
SELECT [Country], [6 Steel Categories], [Category], [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'license' AS [SOURCE], CREATED_AT FROM sima_steel_reader.SIMA_LICENSE_VW
GO