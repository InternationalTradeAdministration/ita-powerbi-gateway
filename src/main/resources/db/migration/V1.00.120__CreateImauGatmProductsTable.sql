IF NOT EXISTS(SELECT *
              FROM sys.objects
              WHERE object_id = OBJECT_ID(N'[imau_gatm].[PRODUCTS]')
                AND type IN (N'U'))
    BEGIN
        CREATE TABLE [imau_gatm].[PRODUCTS]
        (
            [id]              bigint IDENTITY PRIMARY KEY NOT NULL,
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
            [created_at]      datetime                    NOT NULL DEFAULT CURRENT_TIMESTAMP
        )

        CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_DATE ON imau_gatm.PRODUCTS ([date])
        CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_PRODUCT ON imau_gatm.PRODUCTS ([product])
        CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_REPORTER ON imau_gatm.PRODUCTS ([reporter])
        CREATE NONCLUSTERED INDEX INDEX_PRODUCTS_ON_PARTNER ON imau_gatm.PRODUCTS ([partner])
    END
