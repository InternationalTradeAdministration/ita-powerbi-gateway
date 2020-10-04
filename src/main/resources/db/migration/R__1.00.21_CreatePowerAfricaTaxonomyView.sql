CREATE OR ALTER VIEW [power_africa_reader].[taxonomy_tagging]
AS
SELECT id                         [Salesforce Taxonomy ID],
       related_case_id            [Related Case ID],
       name                       [Taxonomy ID],
       trade_region               [Trade Region],
       country                    [Country],
       sector                     [Sector],
       sub_sector                 [Sub-Sector]

FROM [power_africa].[taxonomy_tagging]
GO
