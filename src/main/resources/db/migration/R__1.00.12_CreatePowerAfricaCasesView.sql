CREATE OR ALTER VIEW [power_africa_reader].[cases]
AS
SELECT id                         [Case ID],
       number                     [Case Number],
       subject                    [Subject],
       status                     [Status],
       related_case_id            [Related Case ID],
       organization_id            [Organization ID],
       Actual_Create_Date__c      [Actual Case Create Date],
       Actual_Case_Closed_Date__c [Actual Case Closed Date]

FROM [power_africa].[cases]
GO
