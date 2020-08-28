CREATE TABLE [power_africa].[activities]
(
    case_id    nvarchar(128) NOT NULL,
    subject    nvarchar(255) NOT NULL,
    created_at datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP
)
