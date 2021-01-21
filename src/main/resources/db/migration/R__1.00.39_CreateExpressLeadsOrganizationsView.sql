CREATE OR ALTER VIEW [express_leads_reader].[organizations]
AS
SELECT id           [Organization ID],
       name         [Organization Name],
       owner_name   [Organization Owner Name],
       owner_office [Organization Owner Office]
FROM [express_leads].[organizations]
GO
