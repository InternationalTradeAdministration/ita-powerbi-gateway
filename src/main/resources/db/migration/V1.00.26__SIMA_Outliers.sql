DROP PROCEDURE IF EXISTS sp_SIMA_PRODUCT_OUTLIERS
GO

CREATE PROCEDURE sp_SIMA_PRODUCT_OUTLIERS
AS
BEGIN

  --Check for the required SIMA tables
  IF OBJECT_ID('Product', 'U') IS NULL
  BEGIN
      RETURN 0
  END

  IF OBJECT_ID('StandardLicense', 'U') IS NULL
  BEGIN
      RETURN 0
  END

  DROP TABLE IF EXISTS #tmp_Product
  SELECT p.StandardLicenseId, p.UnitValue, p.Volume, p.HTSNumber, p.ProductCategory, p.ProductDescription
  INTO #tmp_Product
  FROM Product p
  INNER JOIN StandardLicense lic
    ON p.StandardLicenseId = lic.Id
  WHERE lic.Outliers IS NOT NULL and lic.Outliers <> '' 
    AND (lic.LicenseStatus IN ('SUBMITTED', 'CORRECTED'))

  --Evaluate the 1st and 99th percentile!!!
  DROP TABLE IF EXISTS #hts_percentiles_tmp
  SELECT p.HTSNumber,
        p.Volume / nullif(p.UnitValue, 0) AS auv,
        p.Volume,
        percent_rank()
          OVER (
            PARTITION BY p.HTSNumber
            ORDER BY p.Volume / nullif(p.UnitValue, 0) ASC ) AS percent_rank
  INTO #hts_percentiles_tmp
  FROM #tmp_Product p
  WHERE p.HTSNumber IN (
    SELECT HTSNumber
    FROM Product
    GROUP BY HTSNumber
    HAVING count(*) >= 100
  )

  DROP TABLE IF EXISTS #product_outliers_tmp
  CREATE TABLE #product_outliers_tmp (
    HTSNumber VARCHAR(255),
    first_pct_auv DECIMAL(30,20),
    nintynineth_pct_auv DECIMAL(30,20),
    total_entries INT,
    avg_auv FLOAT
  )

  INSERT INTO #product_outliers_tmp (HTSNumber, first_pct_auv, nintynineth_pct_auv)
  SELECT min_auv_q.HTSNumber, min_auv_q.first_pct_auv, max_auv_q.nintynineth_pct_auv
  FROM (
    SELECT HTSNumber, MIN(auv) as nintynineth_pct_auv
    FROM #hts_percentiles_tmp
    WHERE percent_rank >= .99
    GROUP BY HTSNumber) max_auv_q
  INNER JOIN (
    SELECT HTSNumber, MAX(auv) as first_pct_auv
    FROM #hts_percentiles_tmp
    WHERE percent_rank <= .01
    GROUP BY HTSNumber) min_auv_q
  ON max_auv_q.HTSNumber = min_auv_q.HTSNumber

  --When the 1st and 99th percentile do not exist...just use the min and max
  INSERT INTO #product_outliers_tmp(HTSNumber, first_pct_auv, nintynineth_pct_auv)
  SELECT p.HTSNumber,
        MIN(p.Volume / nullif(p.UnitValue,  0)) AS min_auv,
        MAX(p.Volume /nullif(p.UnitValue,  0)) AS max_auv
  FROM   #tmp_Product p
  WHERE p.HTSNumber IN (
    SELECT HTSNumber
    FROM Product
    GROUP BY HTSNumber
    HAVING count(*) between 15 and 99
  )
  GROUP BY p.HTSNumber

  --AVG AUV by HTS (Using source table; should we exclude CONTACTED here?)
  UPDATE outliers
  SET outliers.avg_auv = product.avg_auv
  FROM #product_outliers_tmp outliers
  INNER JOIN (
    SELECT Product.HTSNumber, AVG(product.Volume / nullif(product.UnitValue, 0)) as avg_auv
    FROM #product_outliers_tmp outliers
    INNER JOIN #tmp_Product product
    ON outliers.HTSNumber = product.HTSNumber
    GROUP BY product.HTSNumber
  ) product
  ON outliers.HTSNumber = product.HTSNumber

  --Total license entries by HTS (Using source table; should we exclude CONTACTED here?)
  UPDATE outliers
  SET outliers.total_entries = product.total
  FROM #product_outliers_tmp outliers
  INNER JOIN (
    SELECT HTSNumber, COUNT(*) as total
    FROM #tmp_Product product
    WHERE HTSNumber in (SELECT HTSNumber FROM #product_outliers_tmp)
    GROUP BY HTSNumber
  ) product
  ON outliers.HTSNumber = product.HTSNumber

  DROP TABLE IF EXISTS [dbo].[SIMA_PRODUCT_OUTLIERS_RANGE]
  CREATE TABLE [dbo].[SIMA_PRODUCT_OUTLIERS_RANGE] (
    HTSNumber varchar(255) NOT NULL,
    bottom_auv DECIMAL(30,20),
    bottom_start_auv DECIMAL(30,20),
    bottom_end_auv DECIMAL(30,20),
    top_auv DECIMAL(30,20),
    top_start_auv DECIMAL(30,20),
    top_end_auv DECIMAL(30,20),
    avg_auv FLOAT,
    total_entries INT
  )

  INSERT INTO [dbo].[SIMA_PRODUCT_OUTLIERS_RANGE]
  SELECT outliers.HTSNumber,
    outliers.first_pct_auv,
    outliers.first_pct_auv * .6 as sixty_percent_of_first_percentile,
    outliers.first_pct_auv * .3 as thirty_percent_of_first_percentile,
    outliers.nintynineth_pct_auv,
    outliers.nintynineth_pct_auv * 1.25 as one_hundred_twenth_five_percent_of_first_percentile,
    outliers.nintynineth_pct_auv * 1.75 as one_hundred_seventy_five_percent_of_first_percentile,
    outliers.avg_auv,
    outliers.total_entries
  FROM #product_outliers_tmp outliers

  DROP TABLE IF EXISTS #final_product_outliers_tmp
  SELECT license.LicenseNumber
    , license.Created
    , product.HTSNumber
    , product.ProductDescription
    , license.CountryofOrigin
    , CASE
        WHEN product.Volume < 5000 AND product.Volume/ nullif(product.UnitValue, 0) BETWEEN outliers.bottom_start_auv AND outliers.bottom_end_auv
          THEN 'low'
        WHEN product.Volume >= 5000 AND product.Volume/ nullif(product.UnitValue, 0) BETWEEN outliers.top_start_auv AND outliers.top_end_auv
          THEN 'high'
        ELSE 'n/a'
      END AS record_type
    , product.UnitValue
    , product.Volume
    , outliers.bottom_auv
    , outliers.top_auv
    , outliers.total_entries
    , outliers.avg_auv
  INTO #final_product_outliers_tmp
  FROM [dbo].[SIMA_PRODUCT_OUTLIERS_RANGE] outliers
  INNER JOIN Product product
  ON outliers.HTSNumber = product.HTSNumber
  INNER JOIN StandardLicense license
  ON license.Id = product.StandardLicenseId

  DROP TABLE IF EXISTS [dbo].[SIMA_PRODUCT_OUTLIERS]
  SELECT *
  INTO [dbo].[SIMA_PRODUCT_OUTLIERS]
  FROM #final_product_outliers_tmp
  WHERE record_type <> 'n/a'

  DROP TABLE IF EXISTS #unusual_countries 
  CREATE TABLE #unusual_countries (
    country varchar(255)
  )

  INSERT INTO #unusual_countries(country)
  SELECT DISTINCT license.CountryofOrigin
  FROM StandardLicense license
  INNER JOIN #tmp_Product product
  ON license.Id = product.StandardLicenseId
  GROUP BY product.ProductCategory, license.CountryofOrigin
  HAVING COUNT(*) < 3
  UNION
  SELECT DISTINCT license.CountryofExportation
  FROM StandardLicense license
  INNER JOIN #tmp_Product product
  ON license.Id = product.StandardLicenseId
  GROUP BY product.ProductCategory, license.CountryofExportation
  HAVING COUNT(*) < 3

  INSERT INTO [dbo].[SIMA_PRODUCT_OUTLIERS]
  SELECT DISTINCT license.LicenseNumber
  , license.Created
  , product.HTSNumber
  , product.ProductDescription
  , license.CountryofOrigin
  , 'rare' as record_type
  , product.UnitValue
  , product.Volume
  , null
  , null
  , null
  , null
  FROM StandardLicense license
  INNER JOIN #tmp_Product product
  ON license.Id = product.StandardLicenseId
  WHERE (
    license.CountryofOrigin IN (SELECT country from #unusual_countries)
    OR
    license.CountryofExportation IN (SELECT country from #unusual_countries)
  )

  DROP TABLE IF EXISTS #tmp_Product
  DROP TABLE IF EXISTS #hts_percentiles_tmp
  DROP TABLE IF EXISTS #product_outliers_tmp
  DROP TABLE IF EXISTS #final_product_outliers_tmp

END
GO
