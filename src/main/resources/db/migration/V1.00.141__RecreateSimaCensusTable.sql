CREATE TABLE [dbo].[SIMA_CENSUS]
(
    [COUNTRY]    [int]             NULL,
    [CTRY_DESC]  [varchar](255)    NULL,
    [COMM_DESC]  [varchar](255)    NULL,
    [STEEL_TYPE] [varchar](255)    NULL,
    [VALUE]      [decimal](30, 10) NULL,
    [NETTON]     [decimal](30, 10) NULL,
    [AVGNETPR]   [decimal](30, 10) NULL,
    [METRICTON]  [decimal](30, 10) NULL,
    [AVGMETPR]   [decimal](30, 10) NULL,
    [STAT_MO]    [int]             NULL,
    [STAT_YEAR]  [int]             NULL,
    [CREATED_AT] [datetime]        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    [id]         [bigint] IDENTITY NOT NULL
)

ALTER TABLE [dbo].[SIMA_CENSUS]
    ADD CONSTRAINT [pk_sima_census_on_id] PRIMARY KEY CLUSTERED ([id] ASC)
