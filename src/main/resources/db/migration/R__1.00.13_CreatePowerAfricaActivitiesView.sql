CREATE OR ALTER VIEW [power_africa_reader].[activities]
AS
SELECT case_id               [Case ID],
       subject               [Subject],
       Actual_Create_Date__c [Actual Create Date]
FROM [power_africa].[activities]
GO
