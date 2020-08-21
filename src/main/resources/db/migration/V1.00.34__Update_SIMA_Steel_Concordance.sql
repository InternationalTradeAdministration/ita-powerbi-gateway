DROP TABLE IF EXISTS [dbo].[SIMA_STEEL_CONCORDANCE]

CREATE TABLE dbo.SIMA_STEEL_CONCORDANCE
(
    "Number"     nvarchar(MAX),
    "New Product Group" nvarchar(MAX),
    "HTS Code 10 Digit"  BIGINT,
    "HTS Description"   nvarchar(MAX),
    "Old Product Group"   nvarchar(MAX),
    "6-steel categories"    nvarchar(MAX)
) 

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_STEEL_CONCORDANCE ON dbo.SIMA_STEEL_CONCORDANCE ("HTS Code 10 Digit")