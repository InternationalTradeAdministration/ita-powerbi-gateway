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

DROP TABLE IF EXISTS [dbo].[GMHR_FLAT_FILE]
GO

CREATE TABLE [dbo].[GMHR_FLAT_FILE]
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
    [Labot Cost Project]    DECIMAL(10),
    [Employee Name] VARCHAR(MAX),
    [Employee No]   INTEGER,
    [Title] VARCHAR(MAX),
    [FullPart Time] VARCHAR(MAX),
    [Duty Station City] INTEGER,
    [Duty Station State]    VARCHAR(MAX),
    [Grade and Step]    VARCHAR(MAX),
    [Pay Plane] VARCHAR(MAX),
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
    [Chargin Org]   VARCHAR(MAX),
    [Comp Earned Hours] DECIMAL(10),
    [Comp Earned Dollars]   DECIMAL(10),
    [AL/SL Used]    DECIMAL(10),
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
