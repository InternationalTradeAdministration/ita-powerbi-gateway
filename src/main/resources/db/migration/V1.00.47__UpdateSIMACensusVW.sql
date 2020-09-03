DROP VIEW [dbo].[SIMA_CENSUS_VW]
GO
CREATE VIEW [dbo].[SIMA_CENSUS_VW]
AS
  SELECT RTRIM([CTRY_DESC]) AS Country,
         [VALUE],
         [NETTON],
         [AVGNETPR],
         [METRICTON] AS [QTYMT],
         [AVGMETPR],
         [STAT_MO]   AS [SMONTH],
         [STAT_YEAR] AS [SYEAR],
         [STEEL_TYPE],
         CASE
           WHEN [STEEL_TYPE] <> 'S' THEN 'C & A'
           ELSE [STEEL_TYPE]
         END         AS grade2,
         CASE
           WHEN [COMM_DESC] LIKE '%..%' THEN Substring([COMM_DESC], 1, Charindex('..', [COMM_DESC]) - 1)
           ELSE [COMM_DESC]
         END         AS Category,
         [CREATED_AT],
         [id]
FROM   [dbo].[SIMA_CENSUS];
GO