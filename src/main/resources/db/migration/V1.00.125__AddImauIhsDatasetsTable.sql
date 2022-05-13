IF NOT EXISTS(SELECT *
              FROM sys.objects
              WHERE object_id = OBJECT_ID(N'[imau].[IHS_DATASETS]')
                AND type IN (N'U'))
    BEGIN
        CREATE TABLE [imau].[IHS_DATASETS]
        (
            [id]                    bigint IDENTITY PRIMARY KEY NOT NULL,
            [name]                  nvarchar(100)               NOT NULL,
            [direction]             nvarchar(15)                NOT NULL,
            [additional_parameters] nvarchar(4000)              NOT NULL,
            [created_at]            datetimeoffset(0)           NOT NULL,
            [updated_at]            datetimeoffset(0)           NOT NULL
        )

        CREATE UNIQUE NONCLUSTERED INDEX INDEX_IHS_DATASETS ON imau.IHS_DATASETS ([name])
    END
