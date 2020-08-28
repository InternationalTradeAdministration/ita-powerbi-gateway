CREATE OR ALTER VIEW [power_africa_reader].[organizations]
AS
SELECT id           [Organization ID],
       name         [Organization Name],
       owner_name   [Organization Owner Name],
       owner_office [Organization Owner Office]
FROM [power_africa].[organizations]
GO
