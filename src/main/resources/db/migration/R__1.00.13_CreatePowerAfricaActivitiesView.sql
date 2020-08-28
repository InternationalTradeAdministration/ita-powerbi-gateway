CREATE OR ALTER VIEW [power_africa_reader].[activities]
AS
SELECT case_id [Case ID],
       subject [Subject]
FROM [power_africa].[activities]
GO
