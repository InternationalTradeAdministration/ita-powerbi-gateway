IF EXISTS(SELECT *
          FROM sys.objects
          WHERE object_id = OBJECT_ID(N'[dbo].[SIMA_ALUMINUM]')
            AND type in (N'U'))
    DROP TABLE [dbo].[SIMA_ALUMINUM]

CREATE TABLE dbo.SIMA_ALUMINUM
(
    direction       nvarchar(6)    NOT NULL,
    reporter        nvarchar(256)  NOT NULL,
    reporter_iso    char(2)        NOT NULL,
    partner         nvarchar(256)  NOT NULL,
    partner_iso     char(2)        NOT NULL,
    product         char(10)       NOT NULL,
    date            char(8)        NOT NULL,
    attribute       nvarchar(8)    NOT NULL,
    attribute_value decimal(19, 0) NOT NULL,
    created_at      datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP
)
