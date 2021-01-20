DROP TABLE IF EXISTS [dbo].[NTTO_COVID_I92]
CREATE TABLE [dbo].[NTTO_COVID_I92] (
    [Month]                            nvarchar(25),
    [International Passengers to US]   nvarchar(25),
    [All Int tofrom US]                nvarchar(25),
    [US Domestic Passengers]           nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_COVID_I94]
CREATE TABLE [dbo].[NTTO_COVID_I94] (
    [Date]                             nvarchar(25),
    [Month]                            nvarchar(25),
    [Total Internaional Visitation]    nvarchar(25),
    [Overseas Visitation]              nvarchar(25),
    [Canada Visitation]                nvarchar(25),
    [Mexico Visitation]                nvarchar(25),
    [Airline Seat Capacity]            nvarchar(25),
    [US Outbound Volume]               nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_BALANCE_TRADE]
CREATE TABLE [dbo].[NTTO_BALANCE_TRADE] (
    [Date]                                     nvarchar(25),
    [Month]                                    nvarchar(25),
    [Total Exports GoodsServices]              nvarchar(25),
    [Total Exports Billions]                   nvarchar(25),
    [Travel Share Exports]                     nvarchar(25),
    [Total Exports GoodsServices YearChange]   nvarchar(25),
    [Travel Exports Year Change]               nvarchar(25),
    [Total Imports GoodsServices]              nvarchar(25),
    [Travel Imports Billions]                  nvarchar(25),
    [Travel Share Imports]                     nvarchar(25),
    [Total Imports GoodsServices YearChange]   nvarchar(25),
    [Travel Imports YearChange]                nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_CONSUMER_CONFIDENCE_MONTHLY]
CREATE TABLE [dbo].[NTTO_CONSUMER_CONFIDENCE_MONTHLY] (
    [Date]                                   nvarchar(25),
    [Month]                                  nvarchar(25),
    [Consumer Confidence Index]              nvarchar(25),
    [Consumer Confidence Index YearChange]   nvarchar(25),
    [VacationIntentions]                     nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_FOOD_RETAIL]
CREATE TABLE [dbo].[NTTO_FOOD_RETAIL] (
    [Date]                                                          nvarchar(25),
    [Month]                                                         nvarchar(25),
    [Food Services and Drinking Places Sales ( 1 Month % Change)]   nvarchar(25),
    [Food Services and Drinking Place Sales (Year-Year % Change)]   nvarchar(25),
    [Hotel Room Demand (Year-Year % Change)]                        nvarchar(25),
    [Hotel Average Daily Rate (ADR) -$ Rate]                        nvarchar(25),
    [Average Daily Rate (Year-Year % Change)]                       nvarchar(25),
    [Hotel Occupancy (Percent)]                                     nvarchar(25),
    [Hotel Occupancy (Year-Year % Change)]                          nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_DRIVE_MONTHLY]
CREATE TABLE [dbo].[NTTO_DRIVE_MONTHLY] (
    [Date]                    nvarchar(25),
    [Month]                   nvarchar(25),
    [Rural Arterial Miles]    nvarchar(25),
    [Drive Travel]            nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_HOTEL_MONTHLY]
CREATE TABLE [dbo].[NTTO_HOTEL_MONTHLY] (
    [Date]                         nvarchar(25),
    [Month]                        nvarchar(25),
    [Hotel Room Demand]            nvarchar(25),
    [Hotel ADR]                    nvarchar(25),
    [Hotel ADR YearChange]         nvarchar(25),
    [Hotel Occupancy]              nvarchar(25),
    [Hotel Occupancy YearChange]   nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_UNEMPLOYMENT_MONTHLY]
CREATE TABLE [dbo].[NTTO_UNEMPLOYMENT_MONTHLY] (
    [Date]                                            nvarchar(25),
    [Month]                                           nvarchar(25),
    [Nonfarm Employment MonthlyChange]                nvarchar(25),
    [Nonfarm Employment YearChange]                   nvarchar(25),
    [National Unemployment Rate]                      nvarchar(25),
    [Leisure and Hospitality Employment MonthChange]  nvarchar(25),
    [Leisure and Hospitality Employment YearChange]   nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_RETAIL_MONTHLY]
CREATE TABLE [dbo].[NTTO_RETAIL_MONTHLY] (
    [Date]                       nvarchar(25),
    [Month]                      nvarchar(25),
    [Retail Sales MonthChange]   nvarchar(25),
    [Retail Sales YearChange]    nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_CENSUS_ARTS]
CREATE TABLE [dbo].[NTTO_CENSUS_ARTS] (
[Date]                                                                               nvarchar(25),
[Less than 6 Months]                                                                 nvarchar(25),
[More than 6 Months]                                                                 nvarchar(25),
[I do not beieve this business will return to its usual level of operations]         nvarchar(25),
[There has been little or not effect on this business\'s usual level of operations]  nvarchar(25),
[This Business has permanently closed]                                               nvarchar(25),
[This business has returned to normal operations]                                    nvarchar(25),
[Industry Type]                                                                      nvarchar(50),
)

DROP TABLE IF EXISTS [dbo].[NTTO_CENSUS_FOOD]
CREATE TABLE [dbo].[NTTO_CENSUS_FOOD] (
[Date]                                                                               nvarchar(25),
[Less than 6 Months]                                                                 nvarchar(25),
[More than 6 Months]                                                                 nvarchar(25),
[I do not beieve this business will return to its usual level of operations]         nvarchar(25),
[There has been little or not effect on this business\'s usual level of operations]  nvarchar(25),
[This Business has permanently closed]                                               nvarchar(25),
[This business has returned to normal operations]                                    nvarchar(25),
[Industry Type]                                                                      nvarchar(50),
)

DROP TABLE IF EXISTS [dbo].[NTTO_TSA]
CREATE TABLE [dbo].[NTTO_TSA] (
[Date]                nvarchar(25),
[TSA YearChange]      nvarchar(25),
[TSA % Year Change]   nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_UNEMPLOYMENT_WEEKLY]
CREATE TABLE [dbo].[NTTO_UNEMPLOYMENT_WEEKLY] (
[Date]                           nvarchar(25),
[Initial weekly jobless claims]  nvarchar(25),
)


DROP TABLE IF EXISTS [dbo].[NTTO_HOTEL_OCCUPANCY]
CREATE TABLE [dbo].[NTTO_HOTEL_OCCUPANCY] (
[Date]                         nvarchar(25),
[Weekly Hotel Occupancy Rate]  nvarchar(25),
[Weekly Hotel Occupancy 2019]  nvarchar(25),
[Occupancy YearChange]         nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_GASOLINE]
CREATE TABLE [dbo].[NTTO_GASOLINE] (
[Date]                      nvarchar(25),
[Weekly US Gasoline 2020]   nvarchar(25),
[Weekly US Gasoline 2019]   nvarchar(25),
[Gasoline YearChnge]        nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_RESTAURANT_SALES]
CREATE TABLE [dbo].[NTTO_RESTAURANT_SALES] (
[Date]                               nvarchar(25),
[Weekly Restaurant ADR YearChange]   nvarchar(25),
[Weekly Restarant Sales DineIn]      nvarchar(25),
[Weekly Restarrant Sales OffPrem]    nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_DRIVE_TRAVEL]
CREATE TABLE [dbo].[NTTO_DRIVE_TRAVEL] (
[Date]                                       nvarchar(25),
[Weekly Drive Travel (Year-Year % Change)]   nvarchar(25),
)


DROP TABLE IF EXISTS [dbo].[NTTO_TRAVEL_SPENDING]
CREATE TABLE [dbo].[NTTO_TRAVEL_SPENDING] (
[Date]                                    nvarchar(25),
[Weekly Travel Spending YearChange]       nvarchar(25),
[Weekly Travel Spending $YearChange]      nvarchar(25),
[Weekly Travel Spending WeeklyBillions]   nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_COVID_DATA]
CREATE TABLE [dbo].[NTTO_COVID_DATA] (
[Date]                         nvarchar(25),
[New US COVID Case]            nvarchar(25),
[Cumulative US COVID Cases]    nvarchar(25),
[New US COVID Deaths]          nvarchar(25),
[Cumulative US COVID Deaths]   nvarchar(25),
)

DROP TABLE IF EXISTS [dbo].[NTTO_CENSUS_SMALL_BUSINESS]
CREATE TABLE [dbo].[NTTO_CENSUS_SMALL_BUSINESS] (
[Date]                               nvarchar(25),
[Total Business]                     nvarchar(25),
[Arts, Entertaiment and Recreation]  nvarchar(25),
[Accomodation and Food Services]     nvarchar(25),
[Question]                           nvarchar(150),
)
