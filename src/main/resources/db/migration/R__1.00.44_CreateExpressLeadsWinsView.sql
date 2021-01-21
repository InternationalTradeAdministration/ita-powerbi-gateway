CREATE OR ALTER VIEW [express_leads_reader].[wins]
AS
SELECT id              [WIN ID],
       organization_id [Organization ID],
       name            [Name],
       WIN_Date__c     [WIN Date]
FROM [express_leads].[wins]
GO
