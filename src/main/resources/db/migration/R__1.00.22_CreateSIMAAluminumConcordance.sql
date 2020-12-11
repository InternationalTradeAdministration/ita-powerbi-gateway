DROP TABLE IF EXISTS [dbo].[SIMA_Aluminum_Concordance]
GO

CREATE TABLE [dbo].[SIMA_Aluminum_Concordance]
(
    [Product Group]   NVARCHAR(255) NOT NULL,
    [HTS Code]        CHAR(10)      NOT NULL,
    [HTS Description] NVARCHAR(255) NOT NULL,
    [Category]        NVARCHAR(255) NOT NULL,
)

CREATE UNIQUE NONCLUSTERED INDEX INDEX_SIMA_ALUMINUM_CONCONDANCE_ON_HTS_CODE ON [dbo].[SIMA_Aluminum_Concordance] ([HTS Code])
