DROP TABLE IF EXISTS [dbo].[OTEXA_EXPORTS]
GO

CREATE TABLE [dbo].[OTEXA_EXPORTS](
	[SCHEDB]        [varchar](25) NULL,
	[REPORT_YEAR]   [integer] NULL,
	[REPORT_MONTH]  [integer] NULL,
	[GROUP]         [varchar](3) NULL,
	[COUNTRY]       [varchar](255) NULL,
	[HEADER_ID]     [varchar](25) NULL,
	[VAL]           [decimal](30, 10) NULL
)
GO
