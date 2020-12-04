DROP TABLE IF EXISTS [dbo].[OTEXA_EXPORTS]
GO

CREATE TABLE [dbo].[OTEXA_EXPORTS](
	[SCHEDB]        [integer] NULL,
	[REPORT_YEAR]   [integer] NULL,
	[REPORT_MONTH]  [integer] NULL,
	[GROUP]         [integer] NULL,
	[COUNTRY]       [varchar](255) NULL,
	[HEADER_ID]     [varchar](25) NULL,
	[VAL]           [decimal](30, 10) NULL
)
GO


DROP TABLE IF EXISTS [dbo].[OTEXA_HEADER_EXPORTS_REF]
GO

CREATE TABLE [dbo].[OTEXA_HEADER_EXPORTS_REF](
	[HEADER_ID]           [varchar](15) NULL,
	[YR]                  [integer] NULL,
	[HEADER_DESCRIPTION]  [varchar](255) NULL,
	[HEADER_TYPE]         [varchar](255) NULL
)
GO
