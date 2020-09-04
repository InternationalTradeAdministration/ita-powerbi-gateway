DROP TABLE IF EXISTS [dbo].[SIMA_STEEL_CONCORDANCE]
GO

CREATE TABLE dbo.SIMA_STEEL_CONCORDANCE
(
    "Number"     nvarchar(MAX),
    "New Product Group" nvarchar(MAX),
    "HTS Code"  BIGINT,
    "HTS Description"   nvarchar(MAX),
    "Old Product Group"   nvarchar(MAX),
    "6 Steel Categories"    nvarchar(MAX)
)
GO

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_STEEL_CONCORDANCE ON dbo.SIMA_STEEL_CONCORDANCE ("HTS Code")


DROP VIEW [dbo].[SIMA_LICENSE_VW]
GO
CREATE VIEW [dbo].[SIMA_LICENSE_VW]
AS
SELECT lic.[Country of Origin] as [Country]
    , SUM(lic.[Value]) as [VALUE]
    , SUM(lic.[Volume]) /1000 as [VOLUME]
    , MONTH(lic.[Date of Importation]) as [SMONTH]
    , YEAR(lic.[Date of Importation]) as [SYEAR]
    , ref.[New Product Group]
    , CASE WHEN [New Product Group] like '%Stainless%' then 'S' ELSE 'C & A' END as grade2
    , ref.[6 Steel Categories]
FROM SIMA_LICENSE lic
JOIN SIMA_STEEL_CONCORDANCE ref
on lic.[HTS Code] = ref.[HTS Code]
GROUP BY lic.[Country of Origin], MONTH(lic.[Date of Importation]), YEAR(lic.[Date of Importation]), ref.[New Product Group], ref.[6 Steel Categories]
GO