IF OBJECT_ID('dbo.KEY_AERO_STATS_QTR_2009_2012', 'U') is not null
drop TABLE dbo.KEY_AERO_STATS_QTR_2009_2012
go

create TABLE KEY_AERO_STATS_QTR_2009_2012 (
    Year int,
    "Quarter" varchar(255),
    "Value of Aircraft & Parts Shipments Current dollars" varchar(255),
    "Value of Aircraft & Parts Shipments Constant dollars (2002=100)" decimal(10,2),
    "Value of Aircraft & Parts Shipments Real Growth" varchar(255),
    "Industrial Production Index (2007=100)1,2 Aerospace Products & Parts" decimal(10,2),
    "Industrial Production Index (2007=100)1,2 Aircraft & Parts" decimal(10,2),
    "Indusrtial Production Index (2007=100)1,2 Defense & Space Equipment" decimal(10,2),
    "Total Employment (000s)" decimal(10,2),
    "Total Employment Growth" varchar(255),
    "Production Workers (000s)" decimal(10,2),
    "Production Workers Growth" varchar(255),
    "Total Aerospace Exports" varchar(255),
    "Total Aerospace Imports" decimal(10,2),
    "Balance of Total Aerospace Trade" varchar(255),
    "Top Foreign Market" varchar(255),
    "2nd Top Foreign Market" varchar(255),
    "3rd Top Foreign Market" varchar(255),
    "4th Top Foreign Market" varchar(255),
    "5th Top Foreign Market" varchar(255),
    "% Total Exports" varchar(255),
    "Top Supplier to United States" varchar(255),
    "2nd Top Supplier to United States" varchar(255),
    "3rd Top Supplier to United States" varchar(255),
    "4th Top Supplier to United States" varchar(255),
    "5th Top Supplier to United States" varchar(255),
    "% Total Imports" varchar(255)
);
go