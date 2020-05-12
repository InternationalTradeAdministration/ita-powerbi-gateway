DROP TABLE IF EXISTS dbo.SIMA_AGGREGATECAT_BY_CAT
go

CREATE TABLE SIMA_AGGREGATECAT_BY_CAT (
    Category varchar(255),
    "Aggregate Category" varchar(255),
    Grade varchar(255)
);
go

DROP TABLE IF EXISTS dbo.SIMA_AGGREGATECAT_BY_HTS
go

CREATE TABLE SIMA_AGGREGATECAT_BY_HTS (
    "HTS Code" varchar(255),
    "HTS Description" varchar(255),
    "Aggregate Category" varchar(255),
    Grade varchar(255)
);
go