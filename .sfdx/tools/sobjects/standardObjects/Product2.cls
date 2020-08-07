// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Product2 {
    global Id Id;
    global String Name;
    global String ProductCode;
    global String Description;
    global Boolean IsActive;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global String Family;
    global String CurrencyIsoCode;
    global ExternalDataSource ExternalDataSource;
    global Id ExternalDataSourceId;
    global String ExternalId;
    global String DisplayUrl;
    global String QuantityUnitOfMeasure;
    global Boolean IsDeleted;
    global Boolean IsArchived;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String StockKeepingUnit;
    global String Additional_Details__c;
    global String Height__c;
    global String Width__c;
    global String Depth__c;
    global String Diameter__c;
    global String Weight__c;
    global List<ActivityHistory> ActivityHistories;
    global List<Asset> Assets;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<Attachment> Attachments;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<NetworkActivityAudit> ParentEntities;
    global List<NetworkUserHistoryRecent> NetworkUserHistoryRecentToRecord;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<PricebookEntry> PricebookEntries;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Product2DataTranslation> DataTranslations;
    global List<Product2Feed> Feeds;
    global List<Product2History> Histories;
    global List<ProductCategoryProduct> ProductCategoryProducts;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Task> Tasks;
    global List<WorkOrderLineItem> WorkOrderLineItems;
    global List<AssetChangeEvent> Product2;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<OpportunityLineItem> Product2;
    global List<OutgoingEmail> RelatedTo;
    global List<TaskChangeEvent> What;

    global Product2 () 
    {
    }
}