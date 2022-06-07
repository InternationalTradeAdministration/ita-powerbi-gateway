IF NOT EXISTS(SELECT 1
              FROM sys.indexes
              WHERE name = N'pk_imau_pipeline_run_schedule'
                AND Object_ID = OBJECT_ID(N'imau.pipeline_run_schedule'))
ALTER TABLE [imau].[pipeline_run_schedule]
    ADD CONSTRAINT [PK_imau_pipeline_run_schedule] PRIMARY KEY CLUSTERED ([id]);

ALTER TABLE [imau].[pipeline_run_schedule]
    ALTER COLUMN [pipeline] nvarchar(150) NOT NULL;
