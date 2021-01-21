CREATE TABLE [express_leads].[cases_wins]
(
    case_id nvarchar(128) NOT NULL,
    win_id  nvarchar(128) NOT NULL
)

CREATE UNIQUE NONCLUSTERED INDEX index_express_leads_cases_wins ON [express_leads].[cases_wins] (case_id, win_id)
