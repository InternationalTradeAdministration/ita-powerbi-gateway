DROP TABLE IF EXISTS [dbo].[OTEXA_MONTHLY_TQ]

CREATE TABLE [dbo].[OTEXA_MONTHLY_TQ] (
    YR          int,
    MON         int,
    SYEF        decimal(3, 1),
    QUANTITY    decimal(15, 1),
    ALTERNAT    decimal(15, 0),
    VAL         decimal(15, 0),
    CIFV        decimal(15, 0),
    USV         decimal(12, 0),
    COUNTRY     varchar(255),
    CAT         int,
    CTRYNUM     int,
    HTS         varchar(25)
)
GO


DROP TABLE IF EXISTS [dbo].[OTEXA_MONTHLY_YEARS_REF]
GO

CREATE TABLE [dbo].[OTEXA_MONTHLY_YEARS_REF] (
    YEAR     INT,
    SOURCE   VARCHAR(255)
)
GO
