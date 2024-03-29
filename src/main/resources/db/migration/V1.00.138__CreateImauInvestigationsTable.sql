CREATE TABLE [imau_adcvd].[INVESTIGATIONS]
(
    internal_id                                 [bigint] IDENTITY NOT NULL,
    Id                                          [nvarchar](18)    NOT NULL,
    OwnerId                                     [nvarchar](18)    NOT NULL,
    IsDeleted                                   [bit]             NOT NULL,
    Name                                        [nvarchar](18)    NOT NULL,
    CreatedDate                                 [smalldatetime]   NOT NULL,
    CreatedById                                 [nvarchar](18)    NOT NULL,
    LastModifiedDate                            [smalldatetime],
    LastModifiedById                            [nvarchar](18),
    SystemModstamp                              [smalldatetime],
    Actual_Amend_Final_Concurrence_to_DAS__c    [smalldatetime],
    Actual_Amend_Final_Issues_to_DAS__c         [smalldatetime],
    Actual_Amend_Prelim_Concurrence_to_DAS__c   [smalldatetime],
    Actual_Amend_Prelim_Issues_to_DAS__c        [smalldatetime],
    Actual_Amended_Final_Signature__c           [smalldatetime],
    Actual_Amended_Prelim_Determination_Sig__c  [smalldatetime],
    Actual_Final_Concurrence_to_DAS__c          [smalldatetime],
    Actual_Final_Issues_to_DAS__c               [smalldatetime],
    Actual_Final_Signature__c                   [smalldatetime],
    Actual_Prelim_Concurrence_to_DAS__c         [smalldatetime],
    Actual_Prelim_Issues_to_DAS__c              [smalldatetime],
    Actual_Preliminary_Signature__c             [smalldatetime],
    AD_Investigation_Aligned_To__c              [nvarchar](18),
    ADCVD_Case__c                               [nvarchar](18),
    ADCVD_Case_Number__c                        [nvarchar](255),
    ADCVD_Case_Number_Text__c                   [nvarchar](255),
    ADCVD_Case_Type__c                          [nvarchar](255),
    ADCVD_Case_Type_Text__c                     [nvarchar](255),
    Amend_Final_Concurrence_Due_to_DAS__c       [smalldatetime],
    Amend_Final_Issues_Due_to_DAS__c            [smalldatetime],
    Amend_Prelim_Concurrence_Due_to_DAS__c      [smalldatetime],
    Amend_Prelim_Issues_Due_to_DAS__c           [smalldatetime],
    Amend_the_Preliminary_Determination__c      [nvarchar](255),
    Amended_Final_Announcement_Date__c          [smalldatetime],
    Amended_Preliminary_Announcement_Date__c    [smalldatetime],
    Announcement_Type__c                        [nvarchar](255),
    Calc_Amended_Prelim_Determination_Sig__c    [smalldatetime],
    Calculated_Amended_Final_Signature__c       [smalldatetime],
    Calculated_Final_Signature__c               [smalldatetime],
    Calculated_ITC_Final_FR_Published__c        [smalldatetime],
    Calculated_ITC_Prelim_Determination__c      [smalldatetime],
    Calculated_Order_FR_Signature__c            [smalldatetime],
    Calculated_Postponement_of_PrelimDeterFR__c [smalldatetime],
    Calculated_Prelim_Extension_Request_File__c [smalldatetime],
    Calculated_Preliminary_Signature__c         [smalldatetime],
    Case_Concat_Text_Values__c                  nvarchar(255),
    CBP_Case_Number__c                          nvarchar(28),
    CBP_Case_Number_Text__c                     nvarchar(255),
    Commodity__c                                nvarchar(255),
    Commodity_Text__c                           nvarchar(255),
    Countervailed_Programs__c                   nvarchar(max),
    Country__c                                  nvarchar(255),
    Country_Text__c                             nvarchar(255),
    Country_in_which_factors_were_valued__c     nvarchar(255),
    Days_Remaining__c                           nvarchar(255),
    Est_ITC_Notification_to_DOC_of_Final_Det__c [smalldatetime],
    Estimated_Order_FR_Published__c             [smalldatetime],
    External_Id__c                              [nvarchar](255),
    Final_Announcement_Date__c                  [smalldatetime],
    Final_Concurrence_Due_to_DAS__c             [smalldatetime],
    Final_Extension_of_days__c                  [decimal](18, 0),
    Final_Extension_Remaining__c                [smallint],
    Final_Issues_Due_to_DAS__c                  [smalldatetime],
    Final_Team_Meeting_Deadline__c              [smalldatetime],
    Have_Custom_Instruction_been_sent__c        [nvarchar](255),
    Injunction__c                               [nvarchar](255),
    Input_Date_of_Post_Prelim_Determ_Sig__c     [smalldatetime],
    Investigation_Name__c                       [nvarchar](255),
    Investigation_Outcome__c                    [nvarchar](255),
    ITC_Finding__c                              [nvarchar](255),
    ITC_Notification_to_DOC_of_Final_Determ__c  [smalldatetime],
    Link__c                                     [nvarchar](500),
    Litigation_Hold_Expiration_Date__c          [smalldatetime],
    Litigation_Resolved__c                      [nvarchar](255),
    Litigation_Status__c                        [nvarchar](255),
    Litigation_YesNo__c                         [nvarchar](255),
    Locked__c                                   [bit],
    Lotus_Notes_History_Data__c                 [nvarchar](max),
    Lotus_Notes_Litigation_ID__c                [nvarchar](250),
    Ministerial_Error_for_final__c              [nvarchar](255),
    Ministerial_Error_for_Prelim__c             [nvarchar](255),
    Next_Announcement_Date__c                   [smalldatetime],
    Next_Due_to_DAS_Deadline__c                 [smalldatetime],
    Next_Major_Deadline__c                      [smalldatetime],
    Next_Office_Deadline__c                     [smalldatetime],
    Next_Office_PM_Deadline__c                  [smalldatetime],
    Number_of_Additional_Companies_Investiga__c [decimal](18, 0),
    Number_of_Companies_Requested__c            [decimal](18, 0),
    Number_of_Mandatory_Companies__c            [decimal](18, 0),
    Office__c                                   [nvarchar](10),
    Period_Covered_End_Date__c                  [smalldatetime],
    Period_Covered_Start_Date__c                [smalldatetime],
    Petition__c                                 [nvarchar](18),
    Petition_Initiation_Signature__c            [smalldatetime],
    Petition_Withdrawn__c                       [smalldatetime],
    Prelim_Concurrence_Due_to_DAS__c            [smalldatetime],
    Prelim_Extension_of_days__c                 [decimal](18, 0),
    Prelim_Issues_Due_to_DAS__c                 [smalldatetime],
    Prelim_Team_Meeting_Deadline__c             [smalldatetime],
    Preliminary_Announcement_Date__c            [smalldatetime],
    Preliminary_Extension_Remaining__c          [smallint],
    Product__c                                  [nvarchar](255),
    Product_Short_Name__c                       [nvarchar](255),
    Product_Short_Name_Text__c                  [nvarchar](255),
    Product_Short_Name_Text_Value__c            [nvarchar](255),
    Product_Text__c                             [nvarchar](255),
    Range_of_Rates_Final__c                     [nvarchar](255),
    Range_of_Rates_Final_Amended__c             [nvarchar](50),
    Range_of_Rates_Prelim__c                    [nvarchar](50),
    Range_of_Rates_Prelim_Amended__c            [nvarchar](50),
    RecordTypeId                                [nvarchar](18),
    Schedule_Refresh__c                         [bit],
    Segment__c                                  [nvarchar](18),
    Signature_of_Prelim_Postponement_FR__c      [smalldatetime],
    Status__c                                   [nvarchar](18),
    Termination_of_Suspension_Gap_Period_Beg__c [smalldatetime],
    This_Petition_Has_An_Investigation__c       [nvarchar](18),
    Tolling_Update__c                           [bit],
    Upstream_Subsidy_Allegation__c              [nvarchar](255),
    Will_you_Amend_the_Final__c                 [nvarchar](255),
    Will_you_Issue_a_Post_Preliminary_Determ__c [nvarchar](255)
)

ALTER TABLE [imau_adcvd].[INVESTIGATIONS]
    ADD CONSTRAINT [pk_investigations_on_internal_id] PRIMARY KEY CLUSTERED ([internal_id] ASC)

CREATE UNIQUE NONCLUSTERED INDEX [index_investigations_on_id] ON [imau_adcvd].[INVESTIGATIONS]
    ([Id] ASC)

CREATE NONCLUSTERED INDEX [index_investigations_on_status__c] ON [imau_adcvd].[INVESTIGATIONS]
    ([Status__c] ASC)

