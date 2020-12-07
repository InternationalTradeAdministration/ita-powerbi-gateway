CREATE OR
ALTER PROCEDURE dbo.FLATTEN_IHS_MARKIT_JSON @json nvarchar(max)
AS
BEGIN
    DECLARE @direction AS nvarchar(max)
    DECLARE @reporter AS nvarchar(max)
    DECLARE @reporter_iso AS char(2)
    DECLARE @partner AS nvarchar(max)
    DECLARE @partner_iso AS char(2)
    DECLARE @product AS nvarchar(max)
    DECLARE @currency AS nvarchar(10)
    DECLARE @unit AS nvarchar(10)
    DECLARE @ihs_markit_trade_data AS TABLE
                                      (
                                          direction       nvarchar(max)  NOT NULL,
                                          reporter        nvarchar(max)  NOT NULL,
                                          reporter_iso    nvarchar(max)  NOT NULL,
                                          partner         nvarchar(max)  NOT NULL,
                                          partner_iso     nvarchar(max)  NOT NULL,
                                          product         nvarchar(max)  NOT NULL,
                                          date            char(8)        NOT NULL,
                                          attribute       nvarchar(8)    NOT NULL,
                                          attribute_unit  nvarchar(10)   NOT NULL,
                                          attribute_value decimal(19, 1) NOT NULL
                                      )

    SELECT @direction = lower(direction),
           @reporter = reporter,
           @reporter_iso = reporter_iso,
           @partner = partner,
           @partner_iso = partner_iso,
           @product = product,
           @currency = currency,
           @unit = unit
    FROM OPENJSON(@json)
                  WITH (
                      direction nvarchar(max) '$.Direction',
                      reporter nvarchar(max) '$.Reporter',
                      reporter_iso nvarchar(max) '$.ReporterIso',
                      partner nvarchar(max) '$.Partner',
                      partner_iso nvarchar(max) '$.PartnerIso',
                      product nvarchar(max) '$.Product',
                      currency nvarchar(10) '$.Currency',
                      unit nvarchar(10) '$.Unit'
                      )

    INSERT INTO @ihs_markit_trade_data (direction,
                                        reporter,
                                        reporter_iso,
                                        partner,
                                        partner_iso,
                                        product,
                                        date,
                                        attribute,
                                        attribute_unit,
                                        attribute_value)
    SELECT @direction,
           @reporter,
           @reporter_iso,
           @partner,
           @partner_iso,
           @product,
           [key],
           'Quantity',
           @unit,
           [value]
    FROM OPENJSON(@json, N'$.Quantity')

    INSERT INTO @ihs_markit_trade_data (direction,
                                        reporter,
                                        reporter_iso,
                                        partner,
                                        partner_iso,
                                        product,
                                        date,
                                        attribute,
                                        attribute_unit,
                                        attribute_value)
    SELECT @direction,
           @reporter,
           @reporter_iso,
           @partner,
           @partner_iso,
           @product,
           [key],
           'Value',
           @currency,
           [value]
    FROM OPENJSON(@json, N'$.Value')

    SELECT * FROM @ihs_markit_trade_data
END
GO
