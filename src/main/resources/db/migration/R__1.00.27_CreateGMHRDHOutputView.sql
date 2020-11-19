CREATE OR ALTER VIEW [dbo].[GMHR_DH_OUTPUT_VIEW]
AS
SELECT flat.[Project Code],
RIGHT(flat.[Project Code],3) as [Fund],
CONCAT(flat.[Object1 Code], flat.[Object2 Code]) as BOC,
flat.[Object1 Code] as BOC_First_2,
flat.[Object2 Code] as BOC_Last_2,
boc.[Detailed Description] as [Detailed Description],
boc.[Sub Group],
boc.[General Description],
boc.[GM Ann/Non Ann],
flat.[Labor Cost Project],
flat.[Employee Name],
flat.Title,
CONCAT(flat.[Duty Station State], flat.[Duty Station City]) as [Duty Station Code],
dh.[Country Name],
dh.[State Name],
dh.[City Name],
dh.[County Name],
LEFT(FORMAT(CONVERT(INT, [Grade and Step]),'0000'), 2) as Grade,
RIGHT(FORMAT(CONVERT(INT, [Grade and Step]),'0000'), 2) as Step,
FORMAT(CONVERT(INT, [Grade and Step]),'0000') as [Grade and Step],
payplan.[Pay Plan] as [Pay Plan],
payplan.Defination,
payplan.[Employee Type],
flat.[PP Applied],
flat.[PP Covered],
payroll.[Payroll Org Code],
payroll.Bureau,
payroll.DAS,
payroll.Region,
flat.[Charging Org],
flat.FCFY
FROM [dbo].[GMHR_DH_FLAT_FILE] flat, [dbo].[BOC_LOOKUP_TABLE] boc, [dbo].[DH_DUTY_STATION_LOOKUP] dh, [dbo].[GM_HR_PAYPLAN_LOOKUP] payplan, [dbo].[ITA_PAYROLL_CODES_LOOKUP] payroll
WHERE CONCAT(flat.[Object1 Code], flat.[Object2 Code]) = boc.BOC AND dh.[Duty Station Code]=CONCAT(flat.[Duty Station State], flat.[Duty Station City])
AND payplan.[Pay Plan]=flat.[Pay Plane] AND payroll.[Payroll Org Code] = flat.[Charging Org]
GO