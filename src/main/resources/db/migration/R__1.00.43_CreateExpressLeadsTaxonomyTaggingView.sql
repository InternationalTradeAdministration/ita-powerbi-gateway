CREATE OR ALTER VIEW [express_leads_reader].[taxonomy_tagging]
AS
SELECT id              [Salesforce Taxonomy ID],
       related_case_id [Related Case ID],
       name            [Taxonomy ID],
       trade_region    [Trade Region],
       country         [Country],
       sector          [Sector],
       sub_sector      [Sub-Sector]

FROM [express_leads].[taxonomy_tagging]
GO
