DROP TABLE IF EXISTS dbo.AERO_TRADE_QUARTERLY
GO

DROP TABLE IF EXISTS dbo.AERO_TOTAL_EXPORTS_QTR
GO

CREATE TABLE dbo.AERO_TOTAL_EXPORTS_QTR(
    "Partner" varchar(255),
    "Year" int,
    "Q01" bigint,
    "Q02" bigint,
    "Q03" bigint,
    "Q04" bigint,
)
GO

DROP TABLE IF EXISTS dbo.AERO_GENERAL_IMPORTS_QTR
GO

CREATE TABLE dbo.AERO_GENERAL_IMPORTS_QTR(
    "Partner" varchar(255),
    "Year" int,
    "Q01" bigint,
    "Q02" bigint,
    "Q03" bigint,
    "Q04" bigint,
)
GO
