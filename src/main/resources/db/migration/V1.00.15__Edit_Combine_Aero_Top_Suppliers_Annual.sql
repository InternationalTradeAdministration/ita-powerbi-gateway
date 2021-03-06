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

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL_TOTALS
GO

DROP TABLE IF EXISTS dbo.AERO_TOP_SUPPLIERS_ANNUAL
GO

CREATE TABLE AERO_TOP_SUPPLIERS_ANNUAL (
    Supplier varchar(255),
    Value_2015 decimal(10,2),
    percentTotal_2015 decimal(10,4),
    Value_2016 decimal(10,2),
    percentTotal_2016 decimal(10,4),
    Value_2017 decimal(10,2),
    percentTotal_2017 decimal(10,4),
    Value_2018 decimal(10,2),
    percentTotal_2018 decimal(10,4),
    Value_2019 decimal(10,2),
    percentTotal_2019 decimal(10,4),
);
GO