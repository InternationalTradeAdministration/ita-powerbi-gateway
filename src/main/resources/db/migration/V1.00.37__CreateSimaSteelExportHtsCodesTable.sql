DROP TABLE IF EXISTS [sima_steel_export].[HTS_CODES]

CREATE TABLE [sima_steel_export].[HTS_CODES]
(
    product       nvarchar(10)   NOT NULL,
    product_group nvarchar(4000) NOT NULL,
    description   nvarchar(4000) NOT NULL,
    created_at    datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_STEEL_EXPORT_HTS_CODES ON [sima_steel_export].[HTS_CODES] (product)
