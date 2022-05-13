IF NOT EXISTS(SELECT *
              FROM sys.objects
              WHERE object_id = OBJECT_ID(N'[imau].[IHS_DATASET_REPORTERS]')
                AND type IN (N'U'))
    BEGIN
        CREATE TABLE [imau].[IHS_DATASET_REPORTERS]
        (
            [ihs_dataset_id] bigint            NOT NULL,
            [reporter]       nvarchar(256)     NOT NULL,
            [created_at]     datetimeoffset(0) NOT NULL
        )

        CREATE UNIQUE NONCLUSTERED INDEX INDEX_IHS_DATASET_REPORTERS ON imau.IHS_DATASET_REPORTERS ([ihs_dataset_id], [reporter])
    END
