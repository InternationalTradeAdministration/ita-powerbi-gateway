CREATE OR ALTER VIEW [imau].[IHS_DATASETS_WITH_EST_TIMESTAMPS]
AS
SELECT d.[id] as [Dataset ID]
     , d.[name] as [Dataset Name]
     , d.[direction] as [Direction]
     , JSON_VALUE(COALESCE(d.additional_parameters, '{}'), '$.productDetailLevel') AS [Product Detail Level]
     , d.[created_at] AT TIME ZONE 'Eastern Standard Time' AS [Created At]
     , d.[updated_at] AT TIME ZONE 'Eastern Standard Time' AS [Updated At]
FROM [imau].[IHS_DATASETS] d
GO

CREATE OR ALTER VIEW [imau].[IHS_DATASET_REPORTERS_WITH_EST_TIMESTAMPS]
AS
SELECT r.[ihs_dataset_id] as [Dataset ID]
     , r.[reporter] as [Reporter]
     , r.[created_at] AT TIME ZONE 'Eastern Standard Time' AS [Created At]
FROM [imau].[IHS_DATASET_REPORTERS] r
GO

CREATE OR ALTER VIEW [imau].[IHS_DATASET_HS_CODES_WITH_EST_TIMESTAMPS]
AS
SELECT h.[ihs_dataset_id] as [Dataset ID]
     , h.[hs_code] as [HS Code]
     , h.[created_at] AT TIME ZONE 'Eastern Standard Time' AS [Created At]
FROM [imau].[IHS_DATASET_HS_CODES] h
GO
