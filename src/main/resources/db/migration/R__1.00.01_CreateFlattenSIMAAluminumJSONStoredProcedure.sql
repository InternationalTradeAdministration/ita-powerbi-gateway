CREATE OR ALTER PROCEDURE dbo.FLATTEN_SIMA_ALUMINUM_JSON @json nvarchar(max)
AS
BEGIN
    DECLARE @direction AS nvarchar(max)
    DECLARE @reporter AS nvarchar(max)
    DECLARE @reporter_iso AS char(2)
    DECLARE @partner AS nvarchar(max)
    DECLARE @partner_iso AS char(2)
    DECLARE @product AS nvarchar(max)
    DECLARE @sima_aluminum AS TABLE
                              (
                                  direction       nvarchar(max)  NOT NULL,
                                  reporter        nvarchar(max)  NOT NULL,
                                  reporter_iso    nvarchar(max)  NOT NULL,
                                  partner         nvarchar(max)  NOT NULL,
                                  partner_iso     nvarchar(max)  NOT NULL,
                                  product         nvarchar(max)  NOT NULL,
                                  date            char(8)        NOT NULL,
                                  attribute       nvarchar(8)    NOT NULL,
                                  attribute_value decimal(19, 1) NOT NULL
                              )

    SELECT @direction = direction,
           @reporter = reporter,
           @reporter_iso = reporter_iso,
           @partner = partner,
           @partner_iso = partner_iso,
           @product = product
    FROM OPENJSON(@json)
                  WITH (
                      direction nvarchar(max) '$.Direction',
                      reporter nvarchar(max) '$.Reporter',
                      reporter_iso nvarchar(max) '$.ReporterIso',
                      partner nvarchar(max) '$.Partner',
                      partner_iso nvarchar(max) '$.PartnerIso',
                      product nvarchar(max) '$.Product'
                      )

    INSERT INTO @sima_aluminum (direction,
                                reporter,
                                reporter_iso,
                                partner,
                                partner_iso,
                                product,
                                date,
                                attribute,
                                attribute_value)
    SELECT @direction,
           @reporter,
           @reporter_iso,
           @partner,
           @partner_iso,
           @product,
           [key],
           'Quantity',
           [value]
    FROM OPENJSON(@json, N'$.Quantity')

    INSERT INTO @sima_aluminum (direction,
                                reporter,
                                reporter_iso,
                                partner,
                                partner_iso,
                                product,
                                date,
                                attribute,
                                attribute_value)
    SELECT @direction,
           @reporter,
           @reporter_iso,
           @partner,
           @partner_iso,
           @product,
           [key],
           'Value',
           [value]
    FROM OPENJSON(@json, N'$.Value')

    SELECT * FROM @sima_aluminum
END
GO