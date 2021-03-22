IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IHS_TRACKER]') AND type in (N'U'))
CREATE TABLE [dbo].[IHS_TRACKER]
(
    id          bigint IDENTITY,
    name        NVARCHAR(100) NOT NULL,
    rows_copied int,
    created_at  datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP
)
