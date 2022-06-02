CREATE OR ALTER VIEW [imau_gatm].[YTD_DATES]
AS
SELECT p.[direction]
     , p.[reporter]
     , MAX(p.[date])                     AS [max_current_ytd_date]
     , DATEADD(YEAR, -1, MAX(p.[date]))  AS [max_previous_ytd_date]
     , DATEADD(YEAR, -10, MAX(p.[date]))  AS [max_previous_10_ytd_date]
     , CAST(MAX(p.[created_at]) AS date) AS [last_updated_on]
FROM [imau_gatm].[PRODUCTS] p
WHERE p.[attribute] = 'Quantity'
GROUP BY p.[direction], p.[reporter]
GO

CREATE OR ALTER VIEW [imau_gatm].[AGGREGATED_PRODUCTS]
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
FROM [imau_gatm].[PRODUCTS] p
         LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [imau_gatm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) >= YEAR(y.[max_previous_10_ytd_date])
  AND YEAR(p.[date]) <= YEAR(y.[max_previous_ytd_date])
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
FROM [imau_gatm].[PRODUCTS] p
         LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [imau_gatm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) >= YEAR(y.[max_previous_10_ytd_date])
  AND YEAR(p.[date]) <= YEAR(y.[max_previous_ytd_date])
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
FROM [imau_gatm].[PRODUCTS] p
         LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [imau_gatm].[YTD_DATES] y ON p.[direction] = y.[direction]
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
FROM [imau_gatm].[PRODUCTS] p
         LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [imau_gatm].[YTD_DATES] y ON p.[direction] = y.[direction]
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
FROM [imau_gatm].[PRODUCTS] p
         LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [imau_gatm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) >= YEAR(y.[max_previous_10_ytd_date])
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
FROM [imau_gatm].[PRODUCTS] p
         LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
                   ON p.[product] = c.[hs_code]
         LEFT JOIN [imau_gatm].[YTD_DATES] y ON p.[direction] = y.[direction]
    AND p.[reporter] = y.[reporter]
WHERE YEAR(p.[date]) >= YEAR(y.[max_previous_10_ytd_date])
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
GO

CREATE OR ALTER VIEW [imau_gatm].[REVERSE_FLOW_YTD_DATES]
AS
SELECT p2.[direction]
     , MIN(p2.[max_current_ytd_date]) AS [reverse_flow_current_ytd_date]
     , DATEADD(YEAR, -1, MIN(p2.[max_current_ytd_date]))  AS [reverse_flow_previous_ytd_date]
     , DATEADD(YEAR, -10, MIN(p2.[max_current_ytd_date]))  AS [reverse_flow_previous_10_ytd_date]
FROM (SELECT p.[direction]
     , p.[reporter]
     , MAX(p.[date]) AS [max_current_ytd_date]
     FROM [imau_gatm].[PRODUCTS] p
     WHERE p.[attribute] = 'Quantity'
     AND p.[date] >= DATEADD(month, -4, (SELECT MAX(p1.[date]) FROM [imau_gatm].[PRODUCTS] p1))
     GROUP BY p.[direction], p.[reporter]
    ) p2
GROUP BY p2.[direction]
GO

CREATE OR ALTER VIEW [imau_gatm].[REVERSE_FLOW_AGGREGATED_PRODUCTS]
AS
SELECT 
    CASE WHEN p.[direction] = 'Export' THEN 'Import'
         WHEN p.[direction] = 'Import' THEN 'Export'
         END                        AS [Direction],
    p.[date]                        AS [Date],
    CAST(YEAR(p.[date]) AS CHAR(4)) AS [Date Label],
    p.[partner]+'*'                 AS [Reporting Country],
    p.[reporter]                    AS [Partner Country],
    c.[product_category]            AS [Product Category],
    p.[attribute]                   AS [Unit of Measure],
    p.[attribute_unit]              AS [Measure Unit],
    CASE WHEN p.[attribute] = 'Quantity' THEN SUM(p.[attribute_value]) / 1000
         WHEN p.[attribute] = 'Value' THEN SUM(p.[attribute_value]) 
         END                        AS [Measure Amount],
    MAX(p.[created_at])             AS [Last Updated]
FROM [imau_gatm].[PRODUCTS] p
    LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
        ON p.[product] = c.[hs_code]
    LEFT JOIN [imau_gatm].[REVERSE_FLOW_YTD_DATES] y 
        ON p.[direction] = y.[direction]
WHERE YEAR(p.[date]) >= YEAR(y.[reverse_flow_previous_10_ytd_date])
  AND YEAR(p.[date]) <= YEAR(y.[reverse_flow_previous_ytd_date])
  AND (p.[partner] = 'United Arab Emirates'
    OR p.[partner] = 'Oman'
    OR p.[partner] = 'Mozambique'
    OR p.[partner] = 'Cambodia'
    OR p.[partner] = 'Laos'
    OR p.[partner] = 'Myanmar'
    OR p.[partner] = 'Vietnam')
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT 
    CASE WHEN p.[direction] = 'Export' THEN 'Import'
         WHEN p.[direction] = 'Import' THEN 'Export'
         END                        AS [Direction],
    p.[date]                        AS [Date],
    CAST(YEAR(p.[date]) AS CHAR(4)) AS [Date Label],
    p.[partner]+'*'                 AS [Reporting Country],
    'World'                         AS [Partner Country],
    c.[product_category]            AS [Product Category],
    p.[attribute]                   AS [Unit of Measure],
    p.[attribute_unit]              AS [Measure Unit],
    CASE WHEN p.[attribute] = 'Quantity' THEN SUM(p.[attribute_value]) / 1000
         WHEN p.[attribute] = 'Value' THEN SUM(p.[attribute_value]) 
         END                        AS [Measure Amount],
    MAX(p.[created_at])             AS [Last Updated]
FROM [imau_gatm].[PRODUCTS] p
    LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
        ON p.[product] = c.[hs_code]
    LEFT JOIN [imau_gatm].[REVERSE_FLOW_YTD_DATES] y 
        ON p.[direction] = y.[direction]
WHERE YEAR(p.[date]) >= YEAR(y.[reverse_flow_previous_10_ytd_date])
  AND YEAR(p.[date]) <= YEAR(y.[reverse_flow_previous_ytd_date])
  AND (p.[partner] = 'United Arab Emirates'
    OR p.[partner] = 'Oman'
    OR p.[partner] = 'Mozambique'
    OR p.[partner] = 'Cambodia'
    OR p.[partner] = 'Laos'
    OR p.[partner] = 'Myanmar'
    OR p.[partner] = 'Vietnam')
GROUP BY p.[direction],
         p.[date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT 
    CASE WHEN p.[direction] = 'Export' THEN 'Import'
         WHEN p.[direction] = 'Import' THEN 'Export'
         END                        AS [Direction],
    p.[date]                        AS [Date],
    CAST(YEAR(y.[reverse_flow_current_ytd_date]) AS CHAR(4)) AS [Date Label],
    p.[partner]+'*'                 AS [Reporting Country],
    p.[reporter]                    AS [Partner Country],
    c.[product_category]            AS [Product Category],
    p.[attribute]                   AS [Unit of Measure],
    p.[attribute_unit]              AS [Measure Unit],
    CASE WHEN p.[attribute] = 'Quantity' THEN SUM(p.[attribute_value]) / 1000
         WHEN p.[attribute] = 'Value' THEN SUM(p.[attribute_value]) 
         END                        AS [Measure Amount],
    MAX(p.[created_at])             AS [Last Updated]
FROM [imau_gatm].[PRODUCTS] p
    LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
        ON p.[product] = c.[hs_code]
    LEFT JOIN [imau_gatm].[REVERSE_FLOW_YTD_DATES] y 
        ON p.[direction] = y.[direction]
WHERE MONTH(y.[reverse_flow_current_ytd_date]) = 12
  AND YEAR(p.[date]) = YEAR(y.[reverse_flow_current_ytd_date])
  AND (p.[partner] = 'United Arab Emirates'
    OR p.[partner] = 'Oman'
    OR p.[partner] = 'Mozambique'
    OR p.[partner] = 'Cambodia'
    OR p.[partner] = 'Laos'
    OR p.[partner] = 'Myanmar'
    OR p.[partner] = 'Vietnam')
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         y.[reverse_flow_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT 
    CASE WHEN p.[direction] = 'Export' THEN 'Import'
         WHEN p.[direction] = 'Import' THEN 'Export'
         END                        AS [Direction],
    p.[date]                        AS [Date],
    CAST(YEAR(y.[reverse_flow_current_ytd_date]) AS CHAR(4)) AS [Date Label],
    p.[partner]+'*'                 AS [Reporting Country],
    'World'                         AS [Partner Country],
    c.[product_category]            AS [Product Category],
    p.[attribute]                   AS [Unit of Measure],
    p.[attribute_unit]              AS [Measure Unit],
    CASE WHEN p.[attribute] = 'Quantity' THEN SUM(p.[attribute_value]) / 1000
         WHEN p.[attribute] = 'Value' THEN SUM(p.[attribute_value]) 
         END                        AS [Measure Amount],
    MAX(p.[created_at])             AS [Last Updated]
FROM [imau_gatm].[PRODUCTS] p
    LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
        ON p.[product] = c.[hs_code]
    LEFT JOIN [imau_gatm].[REVERSE_FLOW_YTD_DATES] y 
        ON p.[direction] = y.[direction]
WHERE MONTH(y.[reverse_flow_current_ytd_date]) = 12
  AND YEAR(p.[date]) = YEAR(y.[reverse_flow_current_ytd_date])
  AND (p.[partner] = 'United Arab Emirates'
    OR p.[partner] = 'Oman'
    OR p.[partner] = 'Mozambique'
    OR p.[partner] = 'Cambodia'
    OR p.[partner] = 'Laos'
    OR p.[partner] = 'Myanmar'
    OR p.[partner] = 'Vietnam')
GROUP BY p.[direction],
         p.[date],
         y.[reverse_flow_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT 
    CASE WHEN p.[Direction] = 'Export' THEN 'Import'
         WHEN p.[Direction] = 'Import' THEN 'Export'
         END                                 AS [Direction],
    p.[date]                                 AS [Date],
    CONCAT(
        'YTD ',
        SUBSTRING(DATENAME(MONTH, y.[reverse_flow_current_ytd_date]), 1, 3),
        ' ',
        CAST(YEAR(p.[date]) AS CHAR(4)))     AS [Date Label],
    p.[partner]+'*'                          AS [Reporting Country],
    p.[reporter]                             AS [Partner Country],
    c.[product_category]                     AS [Product Category],
    p.[attribute]                            AS [Unit of Measure],
    p.[attribute_unit]                       AS [Measure Unit],
    CASE WHEN p.[attribute] = 'Quantity' THEN SUM(p.[attribute_value]) / 1000
         WHEN p.[attribute] = 'Value' THEN SUM(p.[attribute_value]) 
         END                                 AS [Measure Amount],
    MAX(p.created_at)                        AS [Last Updated]
FROM [imau_gatm].[PRODUCTS] p
    LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
        ON p.[product] = c.[hs_code]
    LEFT JOIN [imau_gatm].[REVERSE_FLOW_YTD_DATES] y 
        ON p.[direction] = y.[direction]
WHERE YEAR(p.[date]) >= YEAR(y.[reverse_flow_previous_10_ytd_date])
  AND YEAR(p.[date]) <= YEAR(y.[reverse_flow_current_ytd_date])
  AND MONTH(p.[date]) <= MONTH(y.[reverse_flow_current_ytd_date])
  AND (p.[partner] = 'United Arab Emirates'
    OR p.[partner] = 'Oman'
    OR p.[partner] = 'Mozambique'
    OR p.[partner] = 'Cambodia'
    OR p.[partner] = 'Laos'
    OR p.[partner] = 'Myanmar'
    OR p.[partner] = 'Vietnam')
GROUP BY p.[direction],
         p.[reporter],
         p.[date],
         y.[reverse_flow_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
UNION ALL
SELECT 
    CASE WHEN p.[Direction] = 'Export' THEN 'Import'
         WHEN p.[Direction] = 'Import' THEN 'Export'
         END                                 AS [Direction],
    p.[date]                                 AS [Date],
    CONCAT(
        'YTD ',
        SUBSTRING(DATENAME(MONTH, y.[reverse_flow_current_ytd_date]), 1, 3),
        ' ',
        CAST(YEAR(p.[date]) AS CHAR(4)))     AS [Date Label],
    p.[partner]+'*'                          AS [Reporting Country],
    'World'                                  AS [Partner Country],
    c.[product_category]                     AS [Product Category],
    p.[attribute]                            AS [Unit of Measure],
    p.[attribute_unit]                       AS [Measure Unit],
    CASE WHEN p.[attribute] = 'Quantity' THEN SUM(p.[attribute_value]) / 1000
         WHEN p.[attribute] = 'Value' THEN SUM(p.[attribute_value]) 
         END                                 AS [Measure Amount],
    MAX(p.created_at)                        AS [Last Updated]
FROM [imau_gatm].[PRODUCTS] p
    LEFT JOIN [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] c
        ON p.[product] = c.[hs_code]
    LEFT JOIN [imau_gatm].[REVERSE_FLOW_YTD_DATES] y 
        ON p.[direction] = y.[direction]
WHERE YEAR(p.[date]) >= YEAR(y.[reverse_flow_previous_10_ytd_date])
  AND YEAR(p.[date]) <= YEAR(y.[reverse_flow_current_ytd_date])
  AND MONTH(p.[date]) <= MONTH(y.[reverse_flow_current_ytd_date])
  AND (p.[partner] = 'United Arab Emirates'
    OR p.[partner] = 'Oman'
    OR p.[partner] = 'Mozambique'
    OR p.[partner] = 'Cambodia'
    OR p.[partner] = 'Laos'
    OR p.[partner] = 'Myanmar'
    OR p.[partner] = 'Vietnam')
GROUP BY p.[direction],
         p.[date],
         y.[reverse_flow_current_ytd_date],
         p.[partner],
         c.[product_category],
         p.[attribute],
         p.[attribute_unit]
GO