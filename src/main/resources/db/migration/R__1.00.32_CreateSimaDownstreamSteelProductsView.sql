CREATE OR ALTER VIEW [sima_steel_reader].[SIMA_DOWNSTREAM_STEEL_PRODUCTS]
AS
SELECT direction,
       date,
       product,
       reporter,
       reporter_iso,
       partner,
       partner_iso,
       attribute,
       attribute_unit,
       attribute_value,
       created_at
FROM [dbo].[SIMA_DOWNSTREAM_STEEL_PRODUCTS]
GO
