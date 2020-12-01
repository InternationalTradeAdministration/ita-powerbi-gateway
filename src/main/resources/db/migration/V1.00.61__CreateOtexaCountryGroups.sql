DROP TABLE IF EXISTS [dbo].[OTEXA_COUNTRY_GROUPS]
GO

CREATE TABLE [dbo].[OTEXA_COUNTRY_GROUPS](
	[CTRYNUMBER]             [varchar](4) NULL,
	[COUNTRY]                [varchar](50) NULL,
	[COUNTRY_ABBR_ANNUAL]    [varchar](50) NULL,
	[ALT_COUNTRY_ABBR]       [varchar](50) NULL,
	[COUNTRYGROUP]           [varchar](50) NULL
)
GO
