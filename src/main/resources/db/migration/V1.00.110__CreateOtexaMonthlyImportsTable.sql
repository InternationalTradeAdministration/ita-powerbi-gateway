DROP TABLE IF EXISTS [dbo].[OTEXA_MONTHLY_TQ]

DROP TABLE IF EXISTS [dbo].[OTEXA_MONTHLY_IMPORTS]

CREATE TABLE [dbo].[OTEXA_MONTHLY_IMPORTS] (
    YR          int,
    MON         int,
    SYEF        decimal(3, 1),
    VALUE       decimal(15, 0),
    M2          decimal(15, 2),
    QUANTITY    decimal(15, 1),
    UOM         varchar(25),
    COUNTRY     varchar(255),
    CTRYNUM     int,
    CAT         int,
    CAT_DESC    varchar(255),
    HTS         varchar(25),
    HTS_DESC    VARCHAR(255)
)
GO


DROP TABLE IF EXISTS [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS]

CREATE TABLE [dbo].[OTEXA_MONTHLY_FOOTWEAR_IMPORTS] (
    YR          int,
    MON         int,
    VALUE       decimal(15, 0),
    QUANTITY    decimal(15, 1),
    UOM         varchar(25),
    COUNTRY     varchar(255),
    CTRYNUM     int,
    CAT         int,
    CAT_DESC    varchar(255),
    HTS         varchar(25),
    HTS_DESC    varchar(255),
    TYPE        varchar(255),
    SLABEL      varchar(255)
)
GO


DROP TABLE IF EXISTS [dbo].[OTEXA_MONTHLY_FOOTWEAR_EXPORTS]

CREATE TABLE [dbo].[OTEXA_MONTHLY_FOOTWEAR_EXPORTS] (
    YR            int,
    MON           int,
    VALUE         decimal(15, 0),
    QUANTITY      decimal(15, 1),
    UOM           varchar(25),
    COUNTRY       varchar(255),
    CTRYNUM       int,
    CAT           int,
    CAT_DESC      varchar(255),
    SCHEDB        varchar(25),
    SCHEDB_DESC   varchar(255),
    TYPE          varchar(255),
)
GO
