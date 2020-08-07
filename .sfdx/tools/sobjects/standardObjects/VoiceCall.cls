// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class VoiceCall {
    global Id Id;
    global Boolean IsDeleted;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime CreatedDate;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global SObject Owner;
    global Id OwnerId;
    global Datetime CallStartDateTime;
    global Datetime CallEndDateTime;
    global String FromPhoneNumber;
    global String ToPhoneNumber;
    global Integer CallDurationInSeconds;
    global String VendorCallKey;
    global Double Price;
    global String CurrencyCode;
    global String CallDisposition;
    global String CallType;
    global String VendorParentCallKey;
    global User User;
    global Id UserId;
    global SObject RelatedRecord;
    global Id RelatedRecordId;
    global String VendorType;
    global String ConferenceKey;
    global String CallerIdType;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<FlowRecordRelation> RelatedRecord;

    global VoiceCall () 
    {
    }
}