IF Object_id('dbo.SIMA_CENSUS', 'U') IS NOT NULL
  DROP TABLE DBO.SIMA_CENSUS;

GO

CREATE TABLE SIMA_CENSUS
  (
     [COUNTRY]    INTEGER,
     [CTRY_DESC]  VARCHAR(255),
     [COMM_DESC]  VARCHAR(255),
     [STEEL_TYPE] VARCHAR(255),
     [VALUE]      DECIMAL(30, 10),
     [NETTON]     DECIMAL(30, 10),
     [AVGNETPR]   DECIMAL(30, 10),
     [METRICTON]  DECIMAL(30, 10),
     [AVGMETPR]   DECIMAL(30, 10),
     [STAT_MO]    INTEGER,
     [STAT_YEAR]  INTEGER
  );

GO

IF Object_id('dbo.SIMA_CENSUS_VW', 'U') IS NOT NULL
  DROP VIEW DBO.SIMA_CENSUS_VW;

GO

IF Object_id('dbo.SIMA_CENSUS_VW', 'V') IS NOT NULL
  DROP VIEW DBO.SIMA_CENSUS_VW;

GO

CREATE VIEW SIMA_CENSUS_VW
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
         END         AS Category
  FROM   SIMA_CENSUS;

GO