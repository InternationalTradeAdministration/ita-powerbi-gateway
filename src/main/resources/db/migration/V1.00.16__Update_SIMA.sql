ALTER TABLE
    dbo.SIMA_CENSUS
ADD
    CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
GO

ALTER VIEW dbo.SIMA_CENSUS_VW
AS
  SELECT [CTRY_DESC] AS Country,
         [VALUE],
         [NETTON],
         [AVGNETPR],
         [METRICTON] AS [QTYMT],
         [AVGMETPR],
         [STAT_MO]   AS [SMONTH],
         [STAT_YEAR] AS [SYEAR],
         CASE
           WHEN [STEEL_TYPE] <> 'S' THEN 'C & A'
           ELSE [STEEL_TYPE]
         END         AS grade2,
         CASE
           WHEN [COMM_DESC] LIKE '%LINE PIPE%' THEN 'LINE PIPE'
           ELSE Substring([COMM_DESC], 1, Charindex('.', [COMM_DESC]) - 1)
         END         AS Category,
         [CREATED_AT]
FROM   dbo.SIMA_CENSUS;
GO

ALTER TABLE
    dbo.SIMA_LICENSE
ADD
    CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
GO

ALTER VIEW dbo.SIMA_LICENSE_VW
AS
SELECT lic.[Country of Origin] as [Country]
    , SUM(lic.[Value]) as [VALUE]
    , SUM(lic.[Volume])  / 1000 as [VOLUME]
    , MONTH(lic.[Date of Importation]) as [SMONTH]
    , YEAR(lic.[Date of Importation]) as [SYEAR]
    , ref.Category
    , ref.grade2
    , MAX(lic.[CREATED_AT]) AS CREATED_AT
FROM dbo.SIMA_LICENSE lic
JOIN dbo.SIMA_SMP_BY_HTS_VW ref
ON lic.[HTS Code] = ref.[HTS Code]
GROUP BY lic.[Country of Origin], MONTH(lic.[Date of Importation]), YEAR(lic.[Date of Importation]), ref.Category, ref.grade2
GO

ALTER VIEW dbo.SIMA_STEEL_IMPORT_RPT_VW
AS
SELECT [Country], [Category], [QTYMT] as [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'census' AS [SOURCE], CREATED_AT FROM SIMA_CENSUS_VW UNION ALL
SELECT [Country], [Category], [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'license' AS [SOURCE], CREATED_AT FROM SIMA_LICENSE_VW
GO