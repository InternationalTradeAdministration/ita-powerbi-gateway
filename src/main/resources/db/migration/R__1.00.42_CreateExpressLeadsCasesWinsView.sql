CREATE OR ALTER VIEW [express_leads_reader].[cases_wins]
AS
SELECT case_id [Case ID],
       win_id  [Win ID]
FROM [express_leads].[cases_wins]
GO
