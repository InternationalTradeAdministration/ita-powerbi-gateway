CREATE OR ALTER VIEW [dbo].[OTEXA_COUNTRY_REF_VW]
AS
SELECT
    [OTEXA_COUNTRY_GROUPS].[CTRYNUMBER] as 'CTRY_NUMBER',
    [OTEXA_COUNTRY_GROUPS].[COUNTRY] as 'CTRY_DESCRIPTION',
    [OTEXA_COUNTRY_GROUPS].[COUNTRYGROUP] as 'CTRY_GROUP',
    [OTEXA_COUNTRY_REF].[SOURCE]
FROM [dbo].[OTEXA_COUNTRY_GROUPS] INNER JOIN [dbo].[OTEXA_COUNTRY_REF]
ON [OTEXA_COUNTRY_GROUPS].[CTRYNUMBER] = [OTEXA_COUNTRY_REF].[CTRY_NUMBER]

GO
