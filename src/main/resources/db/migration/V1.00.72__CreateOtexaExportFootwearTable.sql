DROP TABLE IF EXISTS [dbo].[OTEXA_EXPORT_FOOTWEAR]
GO

CREATE TABLE [dbo].[OTEXA_EXPORT_FOOTWEAR](
  [Country]         [varchar](255) NULL,
  [Country Number]  [varchar](255) NULL,
  [CAT_ID]          [int] NULL,
  [CAT_DESC]        [varchar](255) NULL,
  [SCHEDULE_B]      [varchar](25) NULL,
  [SCHEDULE_B_DESC] [varchar](255) NULL,
  [Quantity]        [varchar](25) NULL,
  [HEADER_ID]       [varchar](25) NULL,
  [VAL]             [decimal](30, 10) NULL,
  [DATA_TYPE]       [varchar](25),
  [REPORT_YEAR]     [integer] NULL,
  [REPORT_MONTH]    [integer] NULL,
)
GO
