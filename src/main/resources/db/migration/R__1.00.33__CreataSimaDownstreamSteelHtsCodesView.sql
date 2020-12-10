CREATE OR ALTER VIEW [sima_steel_reader].[SIMA_DOWNSTREAM_STEEL_HTS_CODES]
AS
SELECT direction,
       product,
       product_group
FROM [dbo].[SIMA_DOWNSTREAM_STEEL_HTS_CODES]
GO
