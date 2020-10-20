CREATE OR ALTER VIEW [sima_steel_reader].[SIMASteelOutliers]
AS (
    SELECT LicenseNumber, StandardLicenseId FROM [dbo].[SIMASteelOutliers]
)
GO