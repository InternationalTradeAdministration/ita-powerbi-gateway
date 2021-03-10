DROP TABLE IF EXISTS [dbo].[BEA_CHINA_ITA_DATA]
GO

CREATE TABLE [dbo].[BEA_CHINA_ITA_DATA]
(
    Indicator   VARCHAR(MAX),
    AreaOrCountry   VARCHAR(MAX),
    Frequency   VARCHAR(MAX),
    Year    VARCHAR(MAX),
    TimeSeriesId    VARCHAR(MAX),
    TimeSeriesDescription   VARCHAR(MAX),
    TimePeriod  VARCHAR(MAX),
    CL_UNIT VARCHAR(MAX),
    UNIT_MULT   VARCHAR(MAX),
    DataValue   VARCHAR(MAX)
)
GO

DROP TABLE IF EXISTS [dbo].[BEA_CHINA_INTLSERVTRADE_DATA]
GO

CREATE TABLE [dbo].[BEA_CHINA_INTLSERVTRADE_DATA]
(
    TypeOfService   VARCHAR(MAX),
    TradeDirection  VARCHAR(MAX),
    Affiliation VARCHAR(MAX),
    AreaOrCountry   VARCHAR(MAX),
    Year    VARCHAR(MAX),
    TimeSeriesId    VARCHAR(MAX),
    TimeSeriesDescription   VARCHAR(MAX),
    TimePeriod  VARCHAR(MAX),
    CL_UNIT VARCHAR(MAX),
    UNIT_MULT   VARCHAR(MAX),
    DataValue   VARCHAR(MAX)
)
GO