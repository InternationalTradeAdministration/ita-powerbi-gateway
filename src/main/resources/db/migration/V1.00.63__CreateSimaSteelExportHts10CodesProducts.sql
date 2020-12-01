DROP TABLE IF EXISTS [sima_steel_export].[HTS10_CODES_PRODUCTS]

CREATE TABLE [sima_steel_export].[HTS10_CODES_PRODUCTS]
(
    hts10_code  nvarchar(10)   NOT NULL,
    product     nvarchar(4000) NOT NULL,
    created_at  datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_STEEL_EXPORT_HTS10_CODES_PRODUCTS ON [sima_steel_export].[HTS10_CODES_PRODUCTS] (hts10_code)
