DROP TABLE IF EXISTS [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES]

CREATE TABLE [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES]
(
    hs_code          nvarchar(10)   NOT NULL,
    product_category nvarchar(100) NOT NULL,
    created_at       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE UNIQUE NONCLUSTERED INDEX INDEX_HS_CODES_PRODUCT_CATEGORIES_ON_HS_CODE ON [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] (hs_code)
CREATE NONCLUSTERED INDEX INDEX_HS_CODES_PRODUCT_CATEGORIES_ON_PRODUCT_CATEGORY ON [sima_gstm].[HS_CODES_PRODUCT_CATEGORIES] (product_category)
