IF NOT EXISTS(SELECT *
              FROM sys.objects
              WHERE object_id = OBJECT_ID(N'[imau].[IHS_DATASET_PRODUCTS]')
                AND type IN (N'U'))
    BEGIN
        CREATE TABLE [imau].[IHS_DATASET_PRODUCTS]
        (
            [id]              bigint IDENTITY PRIMARY KEY NOT NULL,
            [ihs_dataset_id]  bigint                      NOT NULL,
            [direction]       nvarchar(6)                 NOT NULL,
            [date]            date                        NOT NULL,
            [product]         nvarchar(10)                NOT NULL,
            [reporter]        nvarchar(256)               NOT NULL,
            [reporter_iso]    nvarchar(5)                 NOT NULL,
            [partner]         nvarchar(256)               NOT NULL,
            [partner_iso]     nvarchar(5)                 NOT NULL,
            [attribute]       nvarchar(8)                 NOT NULL,
            [attribute_unit]  nvarchar(10)                NOT NULL,
            [attribute_value] decimal(19, 2)              NOT NULL,
            [created_at]      datetimeoffset(0)           NOT NULL DEFAULT CURRENT_TIMESTAMP
        )

        CREATE NONCLUSTERED INDEX INDEX_IHS_DATASET_PRODUCTS_ON_ATTRIBUTE ON imau.IHS_DATASET_PRODUCTS ([ihs_dataset_id], [attribute])
        CREATE NONCLUSTERED INDEX INDEX_IHS_DATASET_PRODUCTS_ON_DATE ON imau.IHS_DATASET_PRODUCTS ([ihs_dataset_id], [date])
    END
