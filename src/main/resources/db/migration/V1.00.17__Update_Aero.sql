DROP TABLE IF EXISTS dbo.AERO_TOTAL_TRADE
GO

DROP TABLE IF EXISTS dbo.BLS_AERO_MANUFACTURING_EMPLOYMENT
GO

DROP TABLE IF EXISTS dbo.M3_AIRCRAFT_AND_PARTS_SHIPMENTS
GO

CREATE TABLE dbo.AERO_TOTAL_TRADE(
    "Measure" varchar(255),
    "Country" varchar(255),
    "Year" int,
    "Value" varchar(255),
);
GO

CREATE TABLE dbo.BLS_AERO_MANUFACTURING_EMPLOYMENT(
    "Measure" varchar(255),
    "Year" int,
    "Jan" decimal(10,1),
    "Feb" decimal(10,1),
    "Mar" decimal(10,1),
    "Apr" decimal(10,1),
    "May" decimal(10,1),
    "Jun" decimal(10,1),
    "Jul" decimal(10,1),
    "Aug" decimal(10,1),
    "Sep" decimal(10,1),
    "Oct" decimal(10,1),
    "Nov" decimal(10,1),
    "Dec" decimal(10,1),
    "Annual" decimal(10,1),
);
GO

CREATE TABLE dbo.M3_AIRCRAFT_AND_PARTS_SHIPMENTS(
    "Measure" varchar(255),
    "Year" int,
    "Jan" int,
    "Feb" int,
    "Mar" int,
    "Apr" int,
    "May" int,
    "Jun" int,
    "Jul" int,
    "Aug" int,
    "Sep" int,
    "Oct" int,
    "Nov" int,
    "Dec" int,
    "Annual" int,
);
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_QUARTERLY
GO

DROP TABLE IF EXISTS dbo.KEY_AERO_INDUSTRY_STATS_1989_2010
GO

DROP TABLE IF EXISTS dbo.KEY_STATS_QTR_2004_2008
GO

DROP TABLE IF EXISTS dbo.KEY_AERO_STATS_QTR_2009_2012
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_2015
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_2016
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_2017
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_2018
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_2019
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_2019
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_TOTALS
GO
