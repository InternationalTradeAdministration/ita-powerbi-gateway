CREATE TABLE [imau_adcvd].[HARMONIZED_TARIFF_SCHEDULES]
(
    internal_id                      [bigint] IDENTITY NOT NULL,
    Id                               [nvarchar](18)    NOT NULL,
    OwnerId                          [nvarchar](18)    NOT NULL,
    IsDeleted                        [bit]             NOT NULL,
    Name                             [nvarchar](18)    NOT NULL,
    CreatedDate                      [smalldatetime]   NOT NULL,
    CreatedById                      [nvarchar](18)    NOT NULL,
    LastModifiedDate                 [smalldatetime],
    LastModifiedById                 [nvarchar](18),
    SystemModstamp                   [smalldatetime],
    ADCVD_Case__c                    [nvarchar](18),
    ADCVD_Case_Number_Text__c        [nvarchar](255),
    ADCVD_Case_Type__c               [nvarchar](255),
    ADCVD_Case_Type_Text__c          [nvarchar](255),
    ADCVD_Order__c                   [nvarchar](255),
    Case__c                          [nvarchar](18),
    Case_Concat_Text_Values__c       [nvarchar](255),
    CBP_Case_Number_Text__c          [nvarchar](255),
    Commercial_Diplomacy_Triage__c   [nvarchar](18),
    Commodity__c                     [nvarchar](255),
    Commodity_Text__c                [nvarchar](255),
    Country__c                       [nvarchar](255),
    Country_Text__c                  [nvarchar](255),
    HTS_Number__c                    [nvarchar](10),
    HTS_Number_Formatted__c          [nvarchar](20),
    HTS_Number_Length__c             [tinyint],
    HTS_Type__c                      [nvarchar](255),
    Locked__c                        [bit],
    Product__c                       [nvarchar](255),
    Product_Short_Name__c            [nvarchar](255),
    Product_Short_Name_Text__c       [nvarchar](255),
    Product_Short_Name_Text_Value__c [nvarchar](255),
    Product_Text__c                  [nvarchar](255),
    Product_Text_Value__c            [nvarchar](255),
    RecordTypeId                     [nvarchar](255),
    Suspension_Agreement__c          [nvarchar](18)
)

ALTER TABLE [imau_adcvd].[HARMONIZED_TARIFF_SCHEDULES]
    ADD CONSTRAINT [pk_harmonized_tariff_schedules_on_internal_id] PRIMARY KEY CLUSTERED ([internal_id] ASC)

CREATE UNIQUE NONCLUSTERED INDEX [index_harmonized_tariff_schedules_on_id] ON [imau_adcvd].[HARMONIZED_TARIFF_SCHEDULES]
    ([Id] ASC)

