CREATE OR ALTER VIEW [sima_gstm].[YTD_DATES]
AS
SELECT p.[direction]
     , p.[reporter]
     , MAX(p.[date])                     AS [max_current_ytd_date]
     , DATEADD(year, -1, MAX(p.[date]))  AS [max_previous_ytd_date]
     , CAST(MAX(p.[created_at]) AS date) AS [last_updated_on]
FROM [sima_gstm].[PRODUCTS] p
WHERE p.[attribute] = 'Quantity'
GROUP BY p.[direction], p.[reporter]
