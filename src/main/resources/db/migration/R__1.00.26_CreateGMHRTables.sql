DROP TABLE IF EXISTS [dbo].[BOC_LOOKUP_TABLE]
GO

CREATE TABLE [dbo].[BOC_LOOKUP_TABLE]
(
    [BOC]   INTEGER,
    [Detailed Description]  VARCHAR(MAX),
    [Sub Group] VARCHAR(MAX),
    [General Description]   VARCHAR(MAX),
    [GM Ann/Non Ann]    VARCHAR(MAX),
    [LES Ann/Non Ann]   VARCHAR(MAX)
)
GO

DROP TABLE IF EXISTS [dbo].[DH_DUTY_STATION_LOOKUP]
GO

CREATE TABLE [dbo].[DH_DUTY_STATION_LOOKUP]
(
    ID  INT,
    [Duty Station Code] VARCHAR(MAX),
    [Country Name]  VARCHAR(MAX),
    [State Code]    VARCHAR(MAX),
    [State Name]    VARCHAR(MAX),
    [City Code] VARCHAR(MAX),
    [City Name] VARCHAR(MAX),
    [County Name]   VARCHAR(MAX)
)
GO

DROP TABLE IF EXISTS [dbo].[GMHR_DH_INPUT_TABLE]
GO

CREATE TABLE [dbo].[GMHR_DH_INPUT_TABLE]
(
    [Bureau Code]   INTEGER,
    [Fund Code] INTEGER,
    [Charging Org1 Code]    INTEGER,
    [Charging Org2 Code]    INTEGER,
    [Charging Org3 Code]    INTEGER,
    [Charging Org4 Code]    INTEGER,
    [Owning Org]    VARCHAR(MAX),
    [Project Code]  VARCHAR(MAX),
    [Object1 Code]  INTEGER,
    [Object2 Code]  INTEGER,
    [Task Code] INTEGER,
    [Location No]   INTEGER,
    [Batch Date]    DATETIME,
    [Trans Code]    VARCHAR(MAX),
    [Hourly Rate]   DECIMAL(10),
    [Total Leave Used]  DECIMAL(10),
    [Hours Worked Project]  DECIMAL(10),
    [Labor Cost Project]    DECIMAL(10),
    [Employee Name] VARCHAR(MAX),
    [Emp No]   INTEGER,
    [Title] VARCHAR(MAX),
    [FullPart Time] VARCHAR(MAX),
    [Duty Station City] INTEGER,
    [Duty Station State]    VARCHAR(MAX),
    [Grade and Step]    VARCHAR(MAX),
    [Pay Plan] VARCHAR(MAX),
    [Active Status] VARCHAR(1),
    [PP Applied]    INTEGER,
    [PP Covered]    INTEGER,
    [Type Appointment]  INTEGER,
    [Status Date]   DATETIME,
    [Hire Date] DATETIME,
    FCFY    INTEGER,
    [Trans No]  INTEGER,
    [Document Source]   VARCHAR(MAX),
    [Document No]   INTEGER,
    [Occup Series Code] INTEGER,
    [Emp Type]  VARCHAR(MAX),
    [Charging Org]   VARCHAR(MAX),
    [Comp Earned Hours] DECIMAL(10),
    [Comp Earned Dollars]   DECIMAL(10),
    [AL/SL Used]    DECIMAL(10),
    [Other Used]    DECIMAL(10),
    [Comp Used] DECIMAL(10),
    [Hours Worked PP]   DECIMAL(10)
)
GO

DROP TABLE IF EXISTS [dbo].[ITA_PAYROLL_CODES_LOOKUP]
GO

CREATE TABLE [dbo].[ITA_PAYROLL_CODES_LOOKUP]
(
    [Payroll Org Code]  VARCHAR(MAX),
    [Org Code]  VARCHAR(MAX),
    [Bureau]    VARCHAR(MAX),
    [DAS]   VARCHAR(MAX),
    [Region]    VARCHAR(MAX),
    [Country]   VARCHAR(MAX)
)
GO

DROP TABLE IF EXISTS [dbo].[LES_COUNTRY_NAME_LOOKUP]
GO

CREATE TABLE [dbo].[LES_COUNTRY_NAME_LOOKUP]
(
    [Country Code]  INTEGER,
    [DAS/ED/Office] VARCHAR(MAX),
    [Country Name 1]    VARCHAR(MAX)
)
GO

DROP TABLE IF EXISTS [dbo].[GM_HR_PAYPLAN_LOOKUP]
GO

CREATE TABLE [dbo].[GM_HR_PAYPLAN_LOOKUP]
(
    ID  INTEGER,
    Source  VARCHAR(MAX),
    [Pay Plan]  VARCHAR(MAX),
    [Defination]    VARCHAR(MAX),
    [Employee Type] VARCHAR(MAX)
)
GO

DROP TABLE IF EXISTS [dbo].[GMHR_LES_INPUT_TABLE]
GO

CREATE TABLE [dbo].[GMHR_LES_INPUT_TABLE]
(
    [Line No.]  INTEGER,
    [Period ID] VARCHAR(MAX),
    [Cntry] INTEGER,
    [Country Name]  VARCHAR(MAX),
    [Post]  INTEGER,
    [Sub Post]  INTEGER,
    [Agy]   INTEGER,
    [Bur]   INTEGER,
    [Bureau Name]   VARCHAR(MAX),
    [Bdgt FY] INTEGER,
    [Appropriation] VARCHAR(MAX),
    [Bgn FY]    INTEGER,
    [End FY]    INTEGER,
    Allotment   VARCHAR(MAX),
    [Op Allow]  VARCHAR(MAX),
    [Function]  INTEGER,
    [Object]    INTEGER,
    Project VARCHAR(MAX),
    [Prop ID]   VARCHAR(MAX),
    [Benf Org]  VARCHAR(MAX),
    [Obligation]    VARCHAR(MAX),
    [Currency]  INTEGER,
    [Exchange Rate] DECIMAL(10),
    [Employee ID]   VARCHAR(MAX),
    [Name]  VARCHAR(MAX),
    [Position Number]   INTEGER,
    [Position Title]    VARCHAR(MAX),
    [OPS Working Title] VARCHAR(MAX),
    [Salary Plan]   VARCHAR(MAX),
    [Grade] INTEGER,
    [Step]  INTEGER,
    [Annual Salary] MONEY,
    [Worked Hours]  DECIMAL(10),
    [Amount]    MONEY,
    [Amount in USE] MONEY,
    [Adjusted Amount]   MONEY,
    [Adjusted Amount in USE]    MONEY,
    [Fiscal Hours YTD]  DECIMAL(10),
    [Fiscal Total YTD]  MONEY,
    [Fiscal Total YTD in USE]   MONEY,
    [PP Begin Date] DATETIME,
    [PP End Date]   DATETIME,
    [Payroll Status]    VARCHAR(MAX),
    [Run Date]  DATETIME,
    [Service Center]    VARCHAR(MAX)
)


DROP TABLE IF EXISTS [dbo].[GM_HR_FUNDS_TABLE]
GO

CREATE TABLE [dbo].[GM_HR_FUNDS_TABLE]
(
    Bur INTEGER,
    Fund    INTEGER,
    [project type]    VARCHAR(MAX),
    [charging org]  VARCHAR(MAX),
    Project INTEGER,
    Task    INTEGER,
    [owning org]    VARCHAR(MAX),
    [object class]  VARCHAR(MAX),
    [feeder system number]  VARCHAR(MAX),
    [reference no]  VARCHAR(MAX),
    [vendor name]   VARCHAR(MAX),
    [vendor entity type]    VARCHAR(MAX),
    [trans source]  VARCHAR(MAX),
    [gl end date]   DATETIME,
    [cfs trans no]  INTEGER,
    [fund code fiscal year] INTEGER,
    recoveries  DECIMAL(10),
    [UDOs without recoveries]   DECIMAL(10),
    [unpaid accruals without revoceries]    DECIMAL(10),
    [paid accruals without recoveries]  DECIMAL(10),
    [site]  VARCHAR(MAX)
)