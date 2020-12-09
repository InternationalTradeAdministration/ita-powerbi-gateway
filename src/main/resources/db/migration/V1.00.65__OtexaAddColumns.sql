alter table [dbo].[OTEXA_ANNUAL]
  add
    REPORT_MONTH integer NULL,
    REPORT_YEAR integer NULL

alter table [dbo].[OTEXA_ANNUAL_FOOTWEAR]
  add
    REPORT_MONTH integer NULL,
    REPORT_YEAR integer NULL

alter table [dbo].[OTEXA_MERGED_CAT]
  add
    REPORT_MONTH integer NULL,
    REPORT_YEAR integer NULL

alter table [dbo].[OTEXA_PART_CAT]
  add
    REPORT_MONTH integer NULL,
    REPORT_YEAR integer NULL


drop table if exists [dbo].[OTEXA_REPORT_MONTH]
