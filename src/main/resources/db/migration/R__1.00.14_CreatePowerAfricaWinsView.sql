CREATE OR ALTER VIEW [power_africa_reader].[wins]
AS
SELECT id              [WIN ID],
       organization_id [Organization ID],
       name            [Name],
       WIN_Date__c     [WIN Date]
FROM [power_africa].[wins]
GO
