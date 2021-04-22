IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[imau].[pipeline_run_schedule]') AND type in (N'U'))
CREATE TABLE [imau].[pipeline_run_schedule]
(
    id         bigint IDENTITY,
    date       date          NOT NULL,
    pipeline   nvarchar(100) NOT NULL,
    year       smallint      NOT NULL,
    run_type   nvarchar(10)  NOT NULL,
    status     nvarchar(20)  NOT NULL DEFAULT 'QUEUED',
    created_at datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP
)
