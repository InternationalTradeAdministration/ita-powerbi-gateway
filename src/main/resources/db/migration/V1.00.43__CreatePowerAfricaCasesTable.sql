CREATE TABLE [power_africa].[cases]
(
    id              nvarchar(128)  NOT NULL PRIMARY KEY,
    number          nvarchar(128) NOT NULL,
    subject         nvarchar(255) NOT NULL,
    status          nvarchar(128) NOT NULL,
    related_case_id nvarchar(128) NULL,
    organization_id nvarchar(128) NOT NULL,
    created_at      datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP
)
