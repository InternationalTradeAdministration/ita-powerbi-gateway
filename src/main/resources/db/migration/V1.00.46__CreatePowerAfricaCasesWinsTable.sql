CREATE TABLE [power_africa].[cases_wins]
(
    case_id nvarchar(128) NOT NULL,
    win_id  nvarchar(128) NOT NULL
)

CREATE UNIQUE NONCLUSTERED INDEX index_power_africa_cases_wins ON [power_africa].[cases_wins] (case_id, win_id)
