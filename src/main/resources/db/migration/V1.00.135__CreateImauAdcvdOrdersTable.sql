CREATE TABLE [imau_adcvd].[ADCVD_ORDERS]
(
    internal_id                                [bigint] IDENTITY NOT NULL,
    Id                                         [nvarchar](18)    NOT NULL,
    OwnerId                                    [nvarchar](18)    NOT NULL,
    IsDeleted                                  [bit]             NOT NULL,
    Name                                       [nvarchar](18)    NOT NULL,
    CreatedDate                                [smalldatetime]   NOT NULL,
    CreatedById                                [nvarchar](18)    NOT NULL,
    LastModifiedDate                           [smalldatetime],
    LastModifiedById                           [nvarchar](18),
    SystemModstamp                             [smalldatetime],
    ADCVD_Case__c                              [nvarchar](18),
    ADCVD_Case_Number__c                       [nvarchar](255),
    ADCVD_Case_Number_Text__c                  [nvarchar](255),
    ADCVD_Case_Type__c                         [nvarchar](255),
    ADCVD_Case_Type_Text__c                    [nvarchar](255),
    ADCVD_Order_Name__c                        [nvarchar](255),
    Anniversary_Month__c                       [nvarchar](9),
    Case_Concat_Text_Values__c                 [nvarchar](255),
    CBP_Case_Number__c                         [nvarchar](255),
    CBP_Case_Number_Text__c                    [nvarchar](255),
    Commodity__c                               [nvarchar](255),
    Commodity_Text__c                          [nvarchar](255),
    Country__c                                 [nvarchar](255),
    Country_Text__c                            [nvarchar](255),
    Effective_Date_for_Most_Recent_SunsetFR__c [smalldatetime],
    Effective_Date_of_Revocation__c            [smalldatetime],
    Investigation__c                           [nvarchar](18),
    Link__c                                    [nvarchar](500),
    Locked__c                                  [bit],
    Lotus_Notes_History_Data__c                [nvarchar](max),
    Next_Sunset_Initiation_Date__c             [smalldatetime],
    Next_Sunset_Initiation_Date_UI__c          [nvarchar](255),
    Office__c                                  [nvarchar](10),
    Petition_Case_Type__c                      [nvarchar](255),
    Petition_Filed__c                          [smalldatetime],
    Product__c                                 [nvarchar](255),
    Product_Short_Name__c                      [nvarchar](255),
    Product_Short_Name_Text__c                 [nvarchar](255),
    Product_Short_Name_Text_Value__c           [nvarchar](255),
    Product_Text__c                            [nvarchar](255),
    Product_Text_Value__c                      [nvarchar](255),
    Revocation_Reason__c                       [nvarchar](255),
    Segment_Status__c                          [nvarchar](255),
    Status__c                                  [nvarchar](255),
    Third_Country_Case_Number_s__c             [nvarchar](255),
    This_Investigation_has_an_Order__c         [nvarchar](18)
)

ALTER TABLE [imau_adcvd].[ADCVD_ORDERS]
    ADD CONSTRAINT [pk_adcvd_orders_on_internal_id] PRIMARY KEY CLUSTERED ([internal_id] ASC)

CREATE UNIQUE NONCLUSTERED INDEX [index_adcvd_orders_on_id] ON [imau_adcvd].[ADCVD_ORDERS]
    ([Id] ASC)

CREATE NONCLUSTERED INDEX [index_adcvd_orders_on_status__c] ON [imau_adcvd].[ADCVD_ORDERS]
    ([Status__c] ASC)

