IF OBJECT_ID('dbo.AERO_TOP_SUPPLIERS_ANNUAL', 'U') is not null
drop TABLE dbo.AERO_TOP_SUPPLIERS_ANNUAL
go

create TABLE AERO_TOP_SUPPLIERS_ANNUAL (
   Supplier varchar(255),
   Value_2015 decimal(10,2),
   percentTotal_2015 decimal(10,2),
   Value_2016 decimal(10,2),
   percentTotal_2016 decimal(10,2),
   Value_2017 decimal(10,2),
   percentTotal_2017 decimal(10,2),
   Value_2018 decimal(10,2),
   percentTotal_2018 decimal(10,2),
   Value_2019 decimal(10,2),
   percentTotal_2019 decimal(10,2),
);
go