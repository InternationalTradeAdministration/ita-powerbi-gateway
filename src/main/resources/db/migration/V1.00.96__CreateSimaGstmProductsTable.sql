DROP TABLE IF EXISTS [sima_gstm].[PRODUCTS]

CREATE TABLE [sima_gstm].[PRODUCTS]
(
    direction       nvarchar(6)    NOT NULL,
    date            date           NOT NULL,
    product         nvarchar(10)   NOT NULL,
    reporter        nvarchar(256)  NOT NULL,
    reporter_iso    char(2)        NOT NULL,
    partner         nvarchar(256)  NOT NULL,
    partner_iso     char(2)        NOT NULL,
    attribute       nvarchar(8)    NOT NULL,
    attribute_unit  nvarchar(10)   NOT NULL,
    attribute_value decimal(19, 2) NOT NULL,
    created_at      datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_DATE ON sima_gstm.PRODUCTS ([date])
CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_PRODUCT ON sima_gstm.PRODUCTS ([product])
CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_REPORTER ON sima_gstm.PRODUCTS ([reporter])
CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_PARTNER ON sima_gstm.PRODUCTS ([partner])

