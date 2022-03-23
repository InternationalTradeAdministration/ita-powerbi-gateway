IF NOT EXISTS(SELECT *
              FROM sys.objects
              WHERE object_id = OBJECT_ID(N'[imau_gatm].[HS_CODES_PRODUCT_CATEGORIES]')
                AND type IN (N'U'))
    BEGIN
        CREATE TABLE [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES]
        (
            hs_code          nvarchar(10)  NOT NULL,
            product_category nvarchar(100) NOT NULL,
            created_at       datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP
        )

        CREATE UNIQUE NONCLUSTERED INDEX INDEX_HS_CODES_PRODUCT_CATEGORIES_ON_HS_CODE ON [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] (hs_code)
        CREATE NONCLUSTERED INDEX INDEX_HS_CODES_PRODUCT_CATEGORIES_ON_PRODUCT_CATEGORY ON [imau_gatm].[HS_CODES_PRODUCT_CATEGORIES] (product_category)
    END
