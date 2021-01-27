CREATE OR ALTER VIEW gm_hr_reader.GMHR_DH_INPUT_TABLE
AS
SELECT * FROM [dbo].[GMHR_DH_INPUT_TABLE]
GO

CREATE OR ALTER VIEW gm_hr_reader.GMHR_LES_INPUT_TABLE
AS
SELECT [Line No]  as [Line No],
    [Period ID] ,
    [Cntry] ,
    [Country Name]  ,
    [Post]  ,
    [Sub Post]  ,
    [Agy]   ,
    [Bur]   ,
    [Bureau Name]   ,
    [Bdgt FY] ,
    [Appropriation] ,
    [Bgn FY]    ,
    [End FY]    ,
    Allotment   ,
    [Op Allow]  ,
    [Function]  ,
    [Object]    ,
    Project ,
    [Prop ID]   ,
    [Benf Org]  ,
    [Obligation]    ,
    [Currency]  ,
    [Exchange Rate] ,
    [Employee ID]   ,
    [Name]  ,
    [Position Number]   ,
    [Position Title]    ,
    [OPS Working Title] ,
    [Salary Plan]   ,
    [Grade] ,
    [Step]  ,
    [Annual Salary] ,
    [Worked Hours]  ,
    [Amount]    ,
    [Amount in USE] ,
    [Adjusted Amount]   ,
    [Adjusted Amount in USE]    ,
    [Fiscal Hours YTD]  ,
    [Fiscal Total YTD]  ,
    [Fiscal Total YTD in USE]   ,
    [PP Begin Date] ,
    [PP End Date]   ,
    [Payroll Status]    ,
    [Run Date]  ,
    [Service Center]     FROM [dbo].[GMHR_LES_INPUT_TABLE]
GO

CREATE OR ALTER VIEW gm_hr_reader.GM_HR_FUNDS_TABLE
AS
SELECT * FROM [dbo].[GM_HR_FUNDS_TABLE]
GO