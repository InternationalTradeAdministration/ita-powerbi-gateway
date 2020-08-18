DROP TABLE IF EXISTS [dbo].[SIMA_STEEL_CONCORDANCE]

CREATE TABLE dbo.SIMA_STEEL_CONCORDANCE
(
    "Number"     nvarchar(MAX),
    "New Product Group" nvarchar(MAX),
    "HTS Code"  INT,
    "HTS Description"   nvarchar(MAX),
    "Old Product Description"   nvarchar(MAX),
    "6-steel categories"    nvarchar(MAX)
) 

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_STEEL_CONCORDANCE ON dbo.SIMA_STEEL_CONCORDANCE ("HTS Code")