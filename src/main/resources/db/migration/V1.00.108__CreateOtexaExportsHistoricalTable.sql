DROP TABLE IF EXISTS [dbo].[OTEXA_EXPORTS_HISTORICAL]

CREATE TABLE [dbo].[OTEXA_EXPORTS_HISTORICAL] (
    [REPORT_YEAR]   [integer] NULL,
    [REPORT_MONTH]  [integer] NULL,
    [GROUP]         [varchar](3) NULL,
    [COUNTRY]       [varchar](255) NULL,
    [CTRYNUM]       [integer] NULL,
    [HEADER_ID]     [varchar](25) NULL,
    [VAL]           [decimal](30, 10) NULL
)
GO
