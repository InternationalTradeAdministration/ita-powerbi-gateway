CREATE OR ALTER VIEW [sima_gstm].[AGGREGATED_PRODUCTS]
AS
SELECT p.[direction]                   AS [Direction],
       p.[date]                        AS [Date],
       CAST(YEAR(p.[date]) AS CHAR(4)) AS [Date Label],
       p.[reporter]                    AS [Reporting Country],
       p.[partner]                     AS [Partner Country],
       c.[product_category]            AS [Product Category],
       p.[attribute]                   AS [Unit of Measure],
       p.[attribute_unit]              AS [Measure Unit],
       SUM(p.[attribute_value]) / 1000 AS [Measure Amount],
       MAX(p.[created_at])             AS [Last Updated]
FROM [sima_gstm].[PRODUCTS] p
         LEFT JOIN [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [sima_gstm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) <= YEAR(y.[max_previous_ytd_date])
  AND p.[attribute] = 'Quantity'
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT p.[direction]                   AS [Direction],
       p.[date]                        AS [Date],
       CAST(YEAR(p.[date]) AS CHAR(4)) AS [Date Label],
       p.[reporter]                    AS [Reporting Country],
       p.[partner]                     AS [Partner Country],
       c.[product_category]            AS [Product Category],
       p.[attribute]                   AS [Unit of Measure],
       p.[attribute_unit]              AS [Measure Unit],
       SUM(p.[attribute_value])        AS [Measure Amount],
       MAX(p.[created_at])             AS [Last Updated]
FROM [sima_gstm].[PRODUCTS] p
         LEFT JOIN [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [sima_gstm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) <= YEAR(y.[max_previous_ytd_date])
  AND p.[attribute] = 'Value'
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT p.[direction]                                   AS [Direction],
       p.[date]                                        AS [Date],
       CAST(YEAR(y.[max_current_ytd_date]) AS CHAR(4)) AS [Date Label],
       p.[reporter]                                    AS [Reporting Country],
       p.[partner]                                     AS [Partner Country],
       c.[product_category]                            AS [Product Category],
       p.[attribute]                                   AS [Unit of Measure],
       p.[attribute_unit]                              AS [Measure Unit],
       SUM(p.[attribute_value]) / 1000                 AS [Measure Amount],
       MAX(p.created_at)                               AS [Last Updated]
FROM [sima_gstm].[PRODUCTS] p
         LEFT JOIN [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [sima_gstm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE MONTH(y.[max_current_ytd_date]) = 12
  AND YEAR(p.[date]) >= YEAR(y.[max_current_ytd_date])
  AND p.[attribute] = 'Quantity'
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         y.[max_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT p.[direction]                                   AS [Direction],
       p.[date]                                        AS [Date],
       CAST(YEAR(y.[max_current_ytd_date]) AS CHAR(4)) AS [Date Label],
       p.[reporter]                                    AS [Reporting Country],
       p.[partner]                                     AS [Partner Country],
       c.[product_category]                            AS [Product Category],
       p.[attribute]                                   AS [Unit of Measure],
       p.[attribute_unit]                              AS [Measure Unit],
       SUM(p.[attribute_value])                        AS [Measure Amount],
       MAX(p.[created_at])                             AS [Last Updated]
FROM [sima_gstm].[PRODUCTS] p
         LEFT JOIN [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [sima_gstm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE MONTH(y.[max_current_ytd_date]) = 12
  AND YEAR(p.[date]) >= YEAR(y.[max_current_ytd_date])
  AND p.[attribute] = 'Value'
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         y.[max_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT p.[direction]                            AS [Direction],
       p.[date]                                 AS [Date],
       CONCAT(
               'YTD ',
               SUBSTRING(DATENAME(MONTH, y.[max_current_ytd_date]), 1, 3),
               ' ',
               CAST(YEAR(p.[date]) AS CHAR(4))) AS [Date Label],
       p.[reporter]                             AS [Reporting Country],
       p.[partner]                              AS [Partner Country],
       c.[product_category]                     AS [Product Category],
       p.[attribute]                            AS [Unit of Measure],
       p.[attribute_unit]                       AS [Measure Unit],
       SUM(p.[attribute_value]) / 1000          AS [Measure Amount],
       MAX(p.created_at)                        AS [Last Updated]
FROM [sima_gstm].[PRODUCTS] p
         LEFT JOIN [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [sima_gstm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) >= YEAR(y.[max_previous_ytd_date])
  AND MONTH(p.[date]) <= MONTH(y.[max_current_ytd_date])
  AND p.[attribute] = 'Quantity'
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         y.[max_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT p.[direction]                            AS [Direction],
       p.[date]                                 AS [Date],
       CONCAT(
               'YTD ',
               SUBSTRING(DATENAME(MONTH, y.[max_current_ytd_date]), 1, 3),
               ' ',
               CAST(YEAR(p.[date]) AS CHAR(4))) AS [Date Label],
       p.[reporter]                             AS [Reporting Country],
       p.[partner]                              AS [Partner Country],
       c.[product_category]                     AS [Product Category],
       p.[attribute]                            AS [Unit of Measure],
       p.[attribute_unit]                       AS [Measure Unit],
       SUM(p.[attribute_value])                 AS [Measure Amount],
       MAX(p.[created_at])                      AS [Last Updated]
FROM [sima_gstm].[PRODUCTS] p
         LEFT JOIN [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [sima_gstm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) >= YEAR(y.[max_previous_ytd_date])
  AND MONTH(p.[date]) <= MONTH(y.[max_current_ytd_date])
  AND p.[attribute] = 'Value'
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         y.[max_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
