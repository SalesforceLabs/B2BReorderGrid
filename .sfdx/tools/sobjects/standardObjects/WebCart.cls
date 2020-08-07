// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class WebCart {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global String CurrencyIsoCode;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global WebStore WebStore;
    global Id WebStoreId;
    global Account Account;
    global Id AccountId;
    global String Status;
    global String Type;
    global Boolean IsRepricingNeeded;
    global Datetime LastRepricingDate;
    global String PoNumber;
    global String BillingStreet;
    global String BillingCity;
    global String BillingState;
    global String BillingPostalCode;
    global String BillingCountry;
    global Double BillingLatitude;
    global Double BillingLongitude;
    global String BillingGeocodeAccuracy;
    global Address BillingAddress;
    global Decimal TotalListAmount;
    global Decimal TotalProductAmount;
    global Decimal TotalChargeAmount;
    global Decimal TotalAmount;
    global Decimal TotalProductTaxAmount;
    global Decimal TotalChargeTaxAmount;
    global Decimal TotalTaxAmount;
    global Decimal GrandTotalAmount;
    global Double TotalProductCount;
    global Integer UniqueProductCount;
    global List<CartItem> CartItems;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<WebCartHistory> Histories;
    global List<CartDeliveryGroup> Cart;
    global List<FlowRecordRelation> RelatedRecord;

    global WebCart () 
    {
    }
}