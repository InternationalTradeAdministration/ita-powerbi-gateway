CREATE OR ALTER VIEW [power_africa_reader].[cases]
AS
SELECT id              [Case ID],
       number          [Case Number],
       subject         [Subject],
       status          [Status],
       related_case_id [Related Case ID],
       organization_id [Organization ID]
FROM [power_africa].[cases]
GO
