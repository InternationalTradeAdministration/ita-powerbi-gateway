DROP VIEW [dbo].[SIMA_LICENSE_VW]
GO
CREATE VIEW [dbo].[SIMA_LICENSE_VW]
AS
SELECT lic.[Country of Origin] as [Country]
    , SUM(lic.[Value]) as [VALUE]
    , SUM(lic.[Volume]) /1000 as [VOLUME]
    , MONTH(lic.[Date of Importation]) as [SMONTH]
    , YEAR(lic.[Date of Importation]) as [SYEAR]
    , ref.[New Product Group] as [Category]
    , CASE WHEN [New Product Group] like '%Stainless%' then 'S' ELSE 'C & A' END as grade2
    , ref.[6 Steel Categories]
    , MAX(lic.[CREATED_AT]) AS CREATED_AT
FROM SIMA_LICENSE lic
JOIN SIMA_STEEL_CONCORDANCE ref
on lic.[HTS Code] = ref.[HTS Code]
GROUP BY lic.[Country of Origin], MONTH(lic.[Date of Importation]), YEAR(lic.[Date of Importation]), ref.[New Product Group], ref.[6 Steel Categories]
GO