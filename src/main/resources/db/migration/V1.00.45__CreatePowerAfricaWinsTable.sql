CREATE TABLE [power_africa].[wins]
(
    id              nvarchar(128)  NOT NULL,
    organization_id nvarchar(255)  NOT NULL,
    name            nvarchar(4000) NOT NULL,
    created_at      datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)
