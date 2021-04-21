DROP TABLE IF EXISTS [dbo].[NTTO_TTSA_SUPPLY]
GO

CREATE TABLE [dbo].[NTTO_TTSA_SUPPLY]
(
    Commodity   VARCHAR(MAX),
    [Domestic production at producers prices]   DECIMAL(10),
    [Imports]   DECIMAL(10),
    [Change in private inventories] DECIMAL(10),
    [Wholesale trade margins and transportation costs] DECIMAL(10),
    [Retail trade margins]  DECIMAL(10),
    [Total supply at purchasers prices] DECIMAL(10),
    [Intermediate Private Expenditures] DECIMAL(10),
    [Intermediate Government Expenditures]  DECIMAL(10),
    [Personal consumption expenditures] DECIMAL(10),
    [Gross private fixed investment]    DECIMAL(10),
    [Government final expenditures] DECIMAL(10),
    [Exports of goods and services] DECIMAL(10),
    [Total consumption] DECIMAL(10),
    Year    INTEGER
)
GO