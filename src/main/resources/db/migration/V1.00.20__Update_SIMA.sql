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
    , MAX(lic.[CREATED_AT]) AS CREATED_AT
FROM SIMA_LICENSE lic
JOIN SIMA_SMP_BY_HTS_VW ref
ON lic.[HTS Code] = ref.[HTS_CODE]
GROUP BY  lic.[Country of Origin], MONTH(lic.[Date of Importation]), YEAR(lic.[Date of Importation]), ref.Category, ref.grade2
GO