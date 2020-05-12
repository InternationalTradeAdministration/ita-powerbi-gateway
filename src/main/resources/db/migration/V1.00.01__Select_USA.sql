ALTER TABLE BEA_MNE_COUNTRY ADD ColumnParent VARCHAR(255)
ALTER TABLE BEA_MNE_COUNTRY ADD ColumnParentCode INT
ALTER TABLE BEA_MNE_COUNTRY ADD ColumnGParent VARCHAR(255)
ALTER TABLE BEA_MNE_COUNTRY ADD ColumnGParentCode INT

ALTER TABLE BEA_MNE_COUNTRY_BY_INDUSTRY ADD ColumnParent VARCHAR(255)
ALTER TABLE BEA_MNE_COUNTRY_BY_INDUSTRY ADD ColumnParentCode INT
ALTER TABLE BEA_MNE_COUNTRY_BY_INDUSTRY ADD ColumnGParent VARCHAR(255)
ALTER TABLE BEA_MNE_COUNTRY_BY_INDUSTRY ADD ColumnGParentCode INT

ALTER TABLE BEA_MNE_COUNTRY_UBO_BY_INDUSTRY ADD ColumnParent VARCHAR(255)
ALTER TABLE BEA_MNE_COUNTRY_UBO_BY_INDUSTRY ADD ColumnParentCode INT
ALTER TABLE BEA_MNE_COUNTRY_UBO_BY_INDUSTRY ADD ColumnGParent VARCHAR(255)
ALTER TABLE BEA_MNE_COUNTRY_UBO_BY_INDUSTRY ADD ColumnGParentCode INT

ALTER TABLE BEA_MNE_INDUSTRY ADD ColumnParent VARCHAR(255)
ALTER TABLE BEA_MNE_INDUSTRY ADD ColumnParentCode INT
ALTER TABLE BEA_MNE_INDUSTRY ADD ColumnGParent VARCHAR(255)
ALTER TABLE BEA_MNE_INDUSTRY ADD ColumnGParentCode INT
GO

CREATE TABLE [OECD_GDP] (
   [LOCATION]              VARCHAR(255)
  ,[Country]               VARCHAR(255)
  ,[Subject]               VARCHAR(255)
  ,[Measure]               VARCHAR(255)
  ,[TIME]                  INTEGER
  ,[Unit_Code]             VARCHAR(255)
  ,[Unit]                  VARCHAR(255)
  ,[PowerCode_Code]        INTEGER
  ,[PowerCode]             VARCHAR(255)
  ,[Reference_Period_Code] VARCHAR(255)
  ,[Reference_Period]      VARCHAR(255)
  ,[Value]                 DECIMAL(30,10)
  ,[Flag_Codes]            VARCHAR(255)
  ,[Flags]                 VARCHAR(255)
);
GO

CREATE TABLE [OECD_STRICTNESS_OF_EMPLOYMENT_PROTECTION](
  [Country]                VARCHAR(255)
  ,[Series]                VARCHAR(255)
  ,[TIME]                  INTEGER
  ,[Unit_Code]             VARCHAR(255)
  ,[Unit]                  VARCHAR(255)
  ,[PowerCode_Code]        INTEGER
  ,[PowerCode]             VARCHAR(255)
  ,[Reference_Period_Code] VARCHAR(255)
  ,[Reference_Period]      VARCHAR(255)
  ,[Value]                 DECIMAL(30,10)
  ,[Flag_Codes]            VARCHAR(255)
  ,[Flags]                 VARCHAR(255)
);
GO

CREATE TABLE [OECD_AVERAGE_ANNUAL_HOURS_WORKED_PER_WORKER](
  [Country]                 VARCHAR(255)
  ,[EMPSTAT]                VARCHAR(255)
  ,[Employment_status]      VARCHAR(255)
  ,[Frequency]              VARCHAR(255)
  ,[TIME]                   INTEGER
  ,[Unit_Code]              VARCHAR(255)
  ,[Unit]                   VARCHAR(255)
  ,[PowerCode_Code]         INTEGER
  ,[PowerCode]              VARCHAR(255)
  ,[Reference_Period_Code]  VARCHAR(255)
  ,[Reference_Period]       VARCHAR(255)
  ,[Value]                  DECIMAL(30,10)
  ,[Flag_Codes]             VARCHAR(255)
  ,[Flags]                  VARCHAR(255)
);
GO

create TABLE BEA_MNE_COUNTRY_BY_TYPE (
    [DIRECTIONOFINVESTMENT] VARCHAR(255),
    [OwnershipLevel] INT,
    [Year] INT,
    [SeriesID] INT,
    [SeriesName] VARCHAR(255),
    [Row] VARCHAR(255),
    [Column] VARCHAR(255),
    [RowCode] VARCHAR(255),
    [ColumnCode] VARCHAR(255),
    [TableScale] VARCHAR(255),
    [DataValueUnformatted] VARCHAR(255),
    [DataValue] VARCHAR(255),
    [ColumnParent] VARCHAR(255),
    [ColumnParentCode] INT,
    [ColumnGParent] VARCHAR(255),
    [ColumnGParentCode] INT
);
go

create TABLE BEA_MNE_STATE_BY_TYPE (
    [DIRECTIONOFINVESTMENT] VARCHAR(255),
    [OwnershipLevel] INT,
    [Year] INT,
    [SeriesID] INT,
    [SeriesName] VARCHAR(255),
    [Row] VARCHAR(255),
    [Column] VARCHAR(255),
    [RowCode] VARCHAR(255),
    [ColumnCode] VARCHAR(255),
    [TableScale] VARCHAR(255),
    [DataValueUnformatted] VARCHAR(255),
    [DataValue] VARCHAR(255),
    [ColumnParent] VARCHAR(255),
    [ColumnParentCode] INT,
    [ColumnGParent] VARCHAR(255),
    [ColumnGParentCode] INT
);
go

create TABLE BEA_MNE_INDUSTRY_BY_TYPE (
    [DIRECTIONOFINVESTMENT] VARCHAR(255),
    [OwnershipLevel] INT,
    [Year] INT,
    [SeriesID] INT,
    [SeriesName] VARCHAR(255),
    [Row] VARCHAR(255),
    [Column] VARCHAR(255),
    [RowCode] VARCHAR(255),
    [ColumnCode] VARCHAR(255),
    [TableScale] VARCHAR(255),
    [DataValueUnformatted] VARCHAR(255),
    [DataValue] VARCHAR(255),
    [ColumnParent] VARCHAR(255),
    [ColumnParentCode] INT,
    [ColumnGParent] VARCHAR(255),
    [ColumnGParentCode] INT
);
go

drop table IMF_WEODATA;
create TABLE IMF_WEODATA (
    [WEO Country Code] INT,
    [ISO] VARCHAR(255),
    [WEO Subject Code] VARCHAR(255),
    [Country] VARCHAR(255),
    [Subject Descriptor] VARCHAR(255),
    [Subject Notes] VARCHAR(2500),
    [Units] VARCHAR(255),
    [Scale] VARCHAR(255),
    [Series-specific Notes] VARCHAR(5000),
    [1980] VARCHAR(255),
    [1981] VARCHAR(255),
    [1982] VARCHAR(255),
    [1983] VARCHAR(255),
    [1984] VARCHAR(255),
    [1985] VARCHAR(255),
    [1986] VARCHAR(255),
    [1987] VARCHAR(255),
    [1988] VARCHAR(255),
    [1989] VARCHAR(255),
    [1990] VARCHAR(255),
    [1991] VARCHAR(255),
    [1992] VARCHAR(255),
    [1993] VARCHAR(255),
    [1994] VARCHAR(255),
    [1995] VARCHAR(255),
    [1996] VARCHAR(255),
    [1997] VARCHAR(255),
    [1998] VARCHAR(255),
    [1999] VARCHAR(255),
    [2000] VARCHAR(255),
    [2001] VARCHAR(255),
    [2002] VARCHAR(255),
    [2003] VARCHAR(255),
    [2004] VARCHAR(255),
    [2005] VARCHAR(255),
    [2006] VARCHAR(255),
    [2007] VARCHAR(255),
    [2008] VARCHAR(255),
    [2009] VARCHAR(255),
    [2010] VARCHAR(255),
    [2011] VARCHAR(255),
    [2012] VARCHAR(255),
    [2013] VARCHAR(255),
    [2014] VARCHAR(255),
    [2015] VARCHAR(255),
    [2016] VARCHAR(255),
    [2017] VARCHAR(255),
    [2018] VARCHAR(255),
    [2019] VARCHAR(255),
    [2020] VARCHAR(255),
    [2021] VARCHAR(255),
    [2022] VARCHAR(255),
    [2023] VARCHAR(255),
    [2024] VARCHAR(255),
    [Estimates Start After] VARCHAR(255)
);
go
