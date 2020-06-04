IF OBJECT_ID('dbo.AERO_TOP_SUPPLIERS_QUARTERLY', 'U') IS NOT NULL
DROP TABLE dbo.AERO_TOP_SUPPLIERS_QUARTERLY
GO

CREATE TABLE AERO_TOP_SUPPLIERS_QUARTERLY (
    "Supplier" varchar(255),
    "Value 2019 Q1" decimal(10, 2),
    "% Total 2019 Q1" decimal(10, 4),
    "Value 2019 Q2" decimal(10, 2),
    "% Total 2019 Q2" decimal(10, 4),
    "Value 2019 Q3" decimal(10, 2),
    "% Total 2019 Q3" decimal(10, 4),
    "Value 2019 Q4" decimal(10, 2),
    "% Total 2019 Q4" decimal(10, 4),
    "Value 2018 Q1" decimal(10, 2),
    "% Total 2018 Q1" decimal(10, 4),
    "Value 2018 Q2" decimal(10, 2),
    "% Total 2018 Q2" decimal(10, 4),
    "Value 2018 Q3" decimal(10, 2),
    "% Total 2018 Q3" decimal(10, 4),
    "Value 2018 Q4" decimal(10, 2),
    "% Total 2018 Q4" decimal(10, 4),
    "Value 2017 Q1" decimal(10, 2),
    "% Total 2017 Q1" decimal(10, 4),
    "Value 2017 Q2" decimal(10, 2),
    "% Total 2017 Q2" decimal(10, 4),
    "Value 2017 Q3" decimal(10, 2),
    "% Total 2017 Q3" decimal(10, 4),
    "Value 2017 Q4" decimal(10, 2),
    "% Total 2017 Q4" decimal(10, 4),
    "Value 2016 Q1" decimal(10, 2),
    "% Total 2016 Q1" decimal(10, 4),
    "Value 2016 Q2" decimal(10, 2),
    "% Total 2016 Q2" decimal(10, 4),
    "Value 2016 Q3" decimal(10, 2),
    "% Total 2016 Q3" decimal(10, 4),
    "Value 2016 Q4" decimal(10, 2),
    "% Total 2016 Q4" decimal(10, 4),
);
GO