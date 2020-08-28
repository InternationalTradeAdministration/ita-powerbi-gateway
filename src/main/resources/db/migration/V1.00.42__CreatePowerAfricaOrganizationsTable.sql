CREATE TABLE [power_africa].[organizations]
(
    id           nvarchar(128)  NOT NULL,
    name         nvarchar(4000) NOT NULL,
    owner_name   nvarchar(4000) NOT NULL,
    owner_office nvarchar(4000) NOT NULL,
    created_at   datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)
