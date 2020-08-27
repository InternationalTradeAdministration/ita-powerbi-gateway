DROP TABLE IF EXISTS [sima_steel_export].[PRODUCTS]

CREATE TABLE [sima_steel_export].[PRODUCTS]
(
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
