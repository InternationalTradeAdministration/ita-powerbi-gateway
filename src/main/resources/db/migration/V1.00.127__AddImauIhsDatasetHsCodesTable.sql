IF NOT EXISTS(SELECT *
              FROM sys.objects
              WHERE object_id = OBJECT_ID(N'[imau].[IHS_DATASET_HS_CODES]')
                AND type IN (N'U'))
    BEGIN
        CREATE TABLE [imau].[IHS_DATASET_HS_CODES]
        (
            [ihs_dataset_id] bigint            NOT NULL,
            [hs_code]        nvarchar(10)      NOT NULL,
            [created_at]     datetimeoffset(0) NOT NULL
        )

        CREATE UNIQUE NONCLUSTERED INDEX INDEX_IHS_DATASET_HS_CODES ON imau.IHS_DATASET_HS_CODES ([ihs_dataset_id], [hs_code])
    END
