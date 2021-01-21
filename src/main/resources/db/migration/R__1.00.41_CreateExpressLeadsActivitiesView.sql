CREATE OR ALTER VIEW [express_leads_reader].[activities]
AS
SELECT case_id               [Case ID],
       subject               [Subject],
       Actual_Create_Date__c [Actual Create Date]
FROM [express_leads].[activities]
GO
