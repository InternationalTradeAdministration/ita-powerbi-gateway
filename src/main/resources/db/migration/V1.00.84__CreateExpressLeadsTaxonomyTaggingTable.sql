CREATE TABLE [express_leads].[taxonomy_tagging]
(
    id              nvarchar(128) NOT NULL PRIMARY KEY,
    related_case_id nvarchar(128) NOT NULL,
    country         nvarchar(128) NULL,
    name            nvarchar(128) NULL,
    sector          nvarchar(128) NULL,
    sub_sector      nvarchar(128) NULL,
    trade_region    nvarchar(128) NULL,
)
