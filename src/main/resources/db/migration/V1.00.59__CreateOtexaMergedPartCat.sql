DROP TABLE IF EXISTS [dbo].[OTEXA_MERGED_CAT]
GO

CREATE TABLE [dbo].[OTEXA_MERGED_CAT](
	[Country]      [varchar](255) NULL,
	[MERG_CAT]     [varchar](7) NULL,
	[Description]  [varchar](255) NULL,
	[SYEF]         [decimal](5, 2) NULL,
	[HEADER_ID]    [varchar](25) NULL,
	[VAL]          [decimal](30, 10) NULL
)
GO


DROP TABLE IF EXISTS [dbo].[OTEXA_PART_CAT]
GO

CREATE TABLE [dbo].[OTEXA_PART_CAT](
	[Country]    [varchar](255) NULL,
	[PART_CAT]   [varchar](255) NULL,
	[CAT_ID]     [varchar](3) NULL,
	[HTS]        [varchar](25) NULL,
	[SYEF]       [decimal](5, 2) NULL,
	[HEADER_ID]  [varchar](25) NULL,
	[VAL]        [decimal](30, 10) NULL
)
GO
