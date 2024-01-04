CREATE TABLE [imau_adcvd].[FEDERAL_REGISTERS]
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
    Case_Concat_Text_Values__c       [nvarchar](255),
    CBP_Case_Number_Text__c          [nvarchar](255),
    Cite_Number__c                   [nvarchar](255),
    Commodity__c                     [nvarchar](255),
    Commodity_Text__c                [nvarchar](255),
    Country__c                       [nvarchar](255),
    Country_Text__c                  [nvarchar](255),
    Do_Delete__c                     [bit],
    External_Id__c                   [nvarchar](255),
    FR_Parent__c                     [nvarchar](80),
    FR_URL__c                        [nvarchar](255),
    IDM_URL__c                       [nvarchar](255),
    Investigation__c                 [nvarchar](18),
    Litigation__c                    [nvarchar](18),
    Locked__c                        [bit],
    Petition__c                      [nvarchar](18),
    Product__c                       [nvarchar](255),
    Product_Short_Name__c            [nvarchar](255),
    Product_Short_Name_Text__c       [nvarchar](255),
    Product_Short_Name_Text_Value__c [nvarchar](255),
    Product_Text__c                  [nvarchar](255),
    Product_Text_Value__c            [nvarchar](255),
    Published_Date__c                [smalldatetime],
    Segment__c                       [nvarchar](18),
    Suspension_Agreement__c          [nvarchar](18),
    Tolling_Update__c                [bit],
    Type__c                          [nvarchar](255)
)

ALTER TABLE [imau_adcvd].[FEDERAL_REGISTERS]
    ADD CONSTRAINT [pk_federal_registers_on_internal_id] PRIMARY KEY CLUSTERED ([internal_id] ASC)

CREATE UNIQUE NONCLUSTERED INDEX [index_federal_registers_on_id] ON [imau_adcvd].[FEDERAL_REGISTERS]
    ([Id] ASC)

CREATE NONCLUSTERED INDEX [index_federal_registers_on_type__c] ON [imau_adcvd].[FEDERAL_REGISTERS]
    ([Type__c] ASC)

