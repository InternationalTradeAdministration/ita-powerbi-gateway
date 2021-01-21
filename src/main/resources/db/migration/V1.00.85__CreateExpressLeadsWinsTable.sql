CREATE TABLE [express_leads].[wins]
(
    id              nvarchar(128)  NOT NULL PRIMARY KEY,
    organization_id nvarchar(255)  NOT NULL,
    name            nvarchar(4000) NOT NULL,
    WIN_Date__c     nvarchar(128)  NULL,
    created_at      datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)
