DROP VIEW [dbo].[SIMA_CENSUS_VW]
GO
CREATE VIEW [dbo].[SIMA_CENSUS_VW]
AS
SELECT RTRIM([CTRY_DESC]) AS Country,
         cen.[VALUE],
         cen.[NETTON],
         cen.[AVGNETPR],
         cen.[METRICTON] AS [QTYMT],
         cen.[AVGMETPR],
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
         cen.[CREATED_AT],
         cen.[id],
         ref.[6 Steel Categories]
FROM   [dbo].[SIMA_CENSUS] cen
JOIN dbo.SIMA_STEEL_CONCORDANCE ref
on 
CASE WHEN cen.[COMM_DESC] LIKE '%..%' THEN Substring(cen.[COMM_DESC], 1, Charindex('..', cen.[COMM_DESC]) - 1) ELSE cen.[COMM_DESC]
END = ref.[New Product Group]
GO

ALTER VIEW dbo.SIMA_STEEL_IMPORT_RPT_VW
AS
SELECT [Country], [6 Steel Categories], [Category], [QTYMT] as [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'census' AS [SOURCE], CREATED_AT FROM SIMA_CENSUS_VW UNION ALL
SELECT [Country], [6 Steel Categories], [Category], [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'license' AS [SOURCE], CREATED_AT FROM SIMA_LICENSE_VW
GO