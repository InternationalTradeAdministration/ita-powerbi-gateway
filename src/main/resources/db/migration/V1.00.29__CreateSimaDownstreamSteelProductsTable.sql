DROP TABLE IF EXISTS [dbo].[SIMA_DOWNSTREAM_STEEL_PRODUCTS]

CREATE TABLE dbo.SIMA_DOWNSTREAM_STEEL_PRODUCTS
(
    direction       nvarchar(6)    NOT NULL,
    date            date           NOT NULL,
    product         nvarchar(10)   NOT NULL,
    reporter        nvarchar(256)  NOT NULL,
    reporter_iso    char(2)        NOT NULL,
    partner         nvarchar(256)  NOT NULL,
    partner_iso     char(2)        NOT NULL,
    attribute       nvarchar(8)    NOT NULL,
    attribute_value decimal(19, 0) NOT NULL,
    created_at      datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)
