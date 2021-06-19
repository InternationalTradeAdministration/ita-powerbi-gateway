DROP TABLE IF EXISTS [dbo].[OTEXA_TRADE_BALANCE]

CREATE TABLE [dbo].[OTEXA_TRADE_BALANCE] (
    YR            int,
    MON           int,
    COUNTRY       varchar(255),
    CTRYNUM       int,
    GGRP          varchar(25),
    HEADER_ID     varchar(25),
    VALUE         decimal(15, 0),
)
GO


alter table [dbo].[OTEXA_HEADER_REF]
  add 
    SOURCE   varchar(255) NULL
go

DROP TABLE IF EXISTS [dbo].[OTEXA_HEADER_EXPORTS_REF]
GO
