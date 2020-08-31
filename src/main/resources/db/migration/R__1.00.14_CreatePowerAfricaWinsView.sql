CREATE OR ALTER VIEW [power_africa_reader].[wins]
AS
SELECT id              [Win ID],
       organization_id [Organization ID],
       name            [Name]
FROM [power_africa].[wins]
GO
