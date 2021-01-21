CREATE TABLE [express_leads].[cases]
(
    id                         nvarchar(128)  NOT NULL PRIMARY KEY,
    number                     nvarchar(128)  NOT NULL,
    subject                    nvarchar(255)  NOT NULL,
    status                     nvarchar(128)  NOT NULL,
    related_case_id            nvarchar(128)  NULL,
    organization_id            nvarchar(128)  NOT NULL,
    Actual_Create_Date__c      nvarchar(128)  NULL,
    Actual_Case_Closed_Date__c nvarchar(128)  NULL,
    Contact_Full_Name__c       nvarchar(128)  NULL,
    Description                nvarchar(4000) NULL,
    ITA_Action_Plan__c         nvarchar(4000) NULL,
    created_at                 datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)
