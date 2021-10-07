DROP TABLE IF EXISTS [dbo].[OTEXA_FOOTWEAR_HTS_LOOKUP]

CREATE TABLE [dbo].[OTEXA_FOOTWEAR_HTS_LOOKUP]
(
    Category    int,
    [Category Description]  VARCHAR(MAX),
    HTS VARCHAR(25),
    [HTS Description]   VARCHAR(MAX),
    Quantity    VARCHAR(10)
)
GO
