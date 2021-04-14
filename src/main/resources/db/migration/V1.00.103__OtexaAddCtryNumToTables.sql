alter table [dbo].[OTEXA_ANNUAL]
  add
    CTRYNUM   INT NULL

alter table [dbo].[OTEXA_ANNUAL_FOOTWEAR]
  add
    CTRYNUM   INT NULL

alter table [dbo].[OTEXA_EXPORTS]
  add
    CTRYNUM   INT NULL

alter table [dbo].[OTEXA_MERGED_CAT]
  add
    CTRYNUM   INT NULL

alter table [dbo].[OTEXA_PART_CAT]
  add
    CTRYNUM   INT NULL

alter table [dbo].[OTEXA_COUNTRY_GROUPS]
  drop column
    COUNTRY_ABBR_ANNUAL,
    ALT_COUNTRY_ABBR
