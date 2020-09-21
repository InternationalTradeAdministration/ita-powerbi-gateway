DROP TABLE IF EXISTS [power_africa].[cases]
GO

CREATE TABLE [power_africa].[cases]
(
    id                          nvarchar(128) NOT NULL PRIMARY KEY,
    number                      nvarchar(128) NOT NULL,
    subject                     nvarchar(255) NOT NULL,
    status                      nvarchar(128) NOT NULL,
    related_case_id             nvarchar(128) NULL,
    organization_id             nvarchar(128) NOT NULL,
    Actual_Create_Date__c       nvarchar(128) NULL,
    Actual_Case_Closed_Date__c  nvarchar(128) NULL,
    created_at      datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP
)
