DROP TABLE IF EXISTS [power_africa].[activities]
GO

CREATE TABLE [power_africa].[activities]
(
    case_id                 nvarchar(128) NOT NULL,
    subject                 nvarchar(255) NOT NULL,
    Actual_Create_Date__c   nvarchar(255) NULL,
    created_at datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP
)
