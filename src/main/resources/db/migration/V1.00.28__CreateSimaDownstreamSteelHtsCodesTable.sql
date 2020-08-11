DROP TABLE IF EXISTS [dbo].[SIMA_DOWNSTREAM_STEEL_HTS_CODES]

CREATE TABLE dbo.SIMA_DOWNSTREAM_STEEL_HTS_CODES
(
    direction     nvarchar(6)    NOT NULL,
    product       nvarchar(10)   NOT NULL,
    product_group nvarchar(4000) NOT NULL,
    description   nvarchar(4000) NOT NULL,
    created_at    datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_DOWNSTREAM_STEEL_HTS_CODES ON dbo.SIMA_DOWNSTREAM_STEEL_HTS_CODES (direction, product)
