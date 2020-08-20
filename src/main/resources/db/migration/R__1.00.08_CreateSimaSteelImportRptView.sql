CREATE OR ALTER VIEW sima_steel_reader.SIMA_STEEL_IMPORT_RPT_VW
    AS
        SELECT [Country], [Category], [QTYMT] as [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'census' AS [SOURCE], CREATED_AT FROM SIMA_CENSUS_VW UNION ALL
        SELECT [Country], [Category], [VOLUME], [VALUE], [SMONTH], [SYEAR], [grade2], 'license' AS [SOURCE], CREATED_AT FROM SIMA_LICENSE_VW
GO