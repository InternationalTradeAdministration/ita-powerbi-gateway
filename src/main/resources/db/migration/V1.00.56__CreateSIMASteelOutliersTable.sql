DROP TABLE IF EXISTS [dbo].[SIMASteelOutliers]
GO

CREATE TABLE [dbo].[SIMASteelOutliers]
(
    LicenseNumber   VARCHAR(128),
    StandardLicenseId   INT,
    CountryofOrigin VARCHAR(128),
    HTSNumber   VARCHAR(128),
    ExpectedDateOfImportation   Date,
    ProductCategory VARCHAR(255),
    Mark    VARCHAR(128),
    CustomsValue    DECIMAL(10),
    Volume  DECIMAL(10),
    AUV DECIMAL(10),
    LowPctAUV DECIMAL(10),
    HighPctAUV    DECIMAL(10),
    TotalEntries    INT
);
GO