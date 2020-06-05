alter table [dbo].[SIMA_CENSUS] add id BIGINT IDENTITY
go

DROP VIEW [dbo].[SIMA_CENSUS_VW]
GO
CREATE VIEW [dbo].[SIMA_CENSUS_VW]
AS
  SELECT [CTRY_DESC] AS Country,
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
           WHEN [COMM_DESC] LIKE '%LINE PIPE%' THEN 'LINE PIPE'
           WHEN [COMM_DESC] LIKE '%.%' THEN Substring([COMM_DESC], 1, Charindex('.', [COMM_DESC]) - 1)
           ELSE [COMM_DESC]
         END         AS Category,
         [CREATED_AT],
         [id]
FROM   [dbo].[SIMA_CENSUS];
GO

DROP VIEW [dbo].[SIMA_SMP_BY_HTS_VW]
GO
CREATE VIEW [dbo].[SIMA_SMP_BY_HTS_VW]
AS
SELECT [HTS Code] as [HTS_CODE]
    , UPPER([Category]) as Category
    , CASE WHEN [HTS Description] like '%STAINLESS%' then 'S' ELSE 'C & A' END as grade2
FROM SIMA_SMP_BY_HTS
GO

DROP VIEW [dbo].[SIMA_LICENSE_VW]
GO
CREATE VIEW [dbo].[SIMA_LICENSE_VW]
AS
SELECT lic.[Country of Origin] as [Country]
    , SUM(lic.[Value]) as [VALUE]
    , SUM(lic.[Volume])  / 1000 as [VOLUME]
    , MONTH(lic.[Date of Importation]) as [SMONTH]
    , YEAR(lic.[Date of Importation]) as [SYEAR]
    , ref.Category
    , ref.grade2
FROM SIMA_LICENSE lic
JOIN SIMA_SMP_BY_HTS_VW ref
ON lic.[HTS Code] = ref.[HTS_CODE]
GROUP BY  lic.[Country of Origin], MONTH(lic.[Date of Importation]), YEAR(lic.[Date of Importation]), ref.Category, ref.grade2
GO
