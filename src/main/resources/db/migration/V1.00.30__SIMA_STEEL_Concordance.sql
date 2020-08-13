DROP TABLE IF EXISTS [dbo].[SIMA_STEEL_CONCORDANCE]

CREATE TABLE dbo.SIMA_STEEL_CONCORDANCE
(
    "Number"     nvarchar    NOT NULL,
    "New Product Group" nvarchar   NOT NULL,
    "HTS Code"  nvarchar NOT NULL,
    "HTS Description"   nvarchar NOT NULL,
    "Old Product Description"   NVARCHAR NOT NULL,
    "6-steel categories"    NVARCHAR NOT NULL,
    created_at    datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_STEEL_CONCORDANCE ON dbo.SIMA_STEEL_CONCORDANCE ("HTS Code")