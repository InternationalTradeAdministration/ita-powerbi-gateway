DROP TABLE IF EXISTS dbo.BLS_OES_DATA
GO

DROP TABLE IF EXISTS dbo.BLS_OES_FIELD_DESCRIPTIONS
GO

DROP TABLE IF EXISTS dbo.SOC_DEFINITIONS
GO

CREATE TABLE dbo.BLS_OES_DATA
(
    area    NVARCHAR(MAX),
    area_title  NVARCHAR(MAX),
    area_type   NVARCHAR(MAX),
    naics   NVARCHAR(MAX),
    naics_title NVARCHAR(MAX),
    i_group NVARCHAR(MAX),
    own_code    NVARCHAR(MAX),
    occ_code    NVARCHAR(MAX),
    occ_title   NVARCHAR(MAX),
    o_group NVARCHAR(MAX),
    tot_emp NVARCHAR(MAX),
    emp_prse NVARCHAR(MAX),
    jobs_1000_orig  NVARCHAR(MAX),
    loc_quotient    NVARCHAR(MAX),
    pct_total   NVARCHAR(MAX),
    h_mean  NVARCHAR(MAX),
    a_mean  NVARCHAR(MAX),
    mean_prse NVARCHAR(MAX),
    h_pct10 NVARCHAR(MAX),
    h_pct25 NVARCHAR(MAX),
    h_median    NVARCHAR(MAX),
    h_pct75 NVARCHAR(MAX),
    h_pct90 NVARCHAR(MAX),
    a_pct10 NVARCHAR(MAX),
    a_pct25 NVARCHAR(MAX),
    a_median    NVARCHAR(MAX),
    a_pct75 NVARCHAR(MAX),
    a_pct90 NVARCHAR(MAX),
    annual  NVARCHAR(MAX),
    hourly  NVARCHAR(MAX)
);
GO

CREATE TABLE dbo.BLS_OES_FIELD_DESCRIPTIONS
(
    Field   NVARCHAR(MAX),
    "Field Description" NVARCHAR(MAX)
);
GO

CREATE TABLE dbo.SOC_DEFINITIONS
(
    "SOC Group" NVARCHAR(MAX),
    "SOC Code"  NVARCHAR(MAX),
    "SOC Title" NVARCHAR(MAX),
    "SOC Definition"    NVARCHAR(MAX)
);
GO