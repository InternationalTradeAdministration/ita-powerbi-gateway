DROP TABLE IF EXISTS [dbo].[OIE_TBT_HS4]
CREATE TABLE [dbo].[OIE_TBT_HS4] (
    [country]               nvarchar(max),
    [tracking]              nvarchar(max),
    [year]                  nvarchar(max),
    [measure.description]   nvarchar(max),
    [product.description]   nvarchar(max),
    [keywords]              nvarchar(max),
    [wto.document.number]   nvarchar(max),
    [hs]                    nvarchar(max),
    [length]                nvarchar(max),
    [hs2]                   nvarchar(max),
    [hs4]                   nvarchar(max),
    [hs.full.list]          nvarchar(max),
    [initiation]            nvarchar(max),
    [stc]                   nvarchar(max),
)
