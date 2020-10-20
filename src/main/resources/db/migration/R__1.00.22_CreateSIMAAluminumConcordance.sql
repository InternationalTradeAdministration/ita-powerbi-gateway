DROP TABLE IF EXISTS [dbo].[SIMA_Aluminum_Concordance]
GO

CREATE TABLE [dbo].[SIMA_Aluminum_Concordance]
(
    [Product Group] VARCHAR(255),
    [HTS Code]  VARCHAR(255),
    [HTS Description]   NVARCHAR(MAX),
    [Category]  VARCHAR(255),
    [AUV-MIN]   DECIMAL(10),
    [AUV-High]  DECIMAL(10)
)
GO