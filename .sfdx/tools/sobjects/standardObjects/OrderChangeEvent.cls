// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class OrderChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global User Owner;
    global Id OwnerId;
    global Contract Contract;
    global Id ContractId;
    global Account Account;
    global Id AccountId;
    global Pricebook2 Pricebook2;
    global Id Pricebook2Id;
    global Order OriginalOrder;
    global Id OriginalOrderId;
    global Date EffectiveDate;
    global Date EndDate;
    global Boolean IsReductionOrder;
    global String Status;
    global String Description;
    global Contact CustomerAuthorizedBy;
    global Id CustomerAuthorizedById;
    global User CompanyAuthorizedBy;
    global Id CompanyAuthorizedById;
    global String Type;
    global String BillingStreet;
    global String BillingCity;
    global String BillingState;
    global String BillingPostalCode;
    global String BillingCountry;
    global Double BillingLatitude;
    global Double BillingLongitude;
    global String BillingGeocodeAccuracy;
    global Address BillingAddress;
    global String ShippingStreet;
    global String ShippingCity;
    global String ShippingState;
    global String ShippingPostalCode;
    global String ShippingCountry;
    global Double ShippingLatitude;
    global Double ShippingLongitude;
    global String ShippingGeocodeAccuracy;
    global Address ShippingAddress;
    global Datetime ActivatedDate;
    global User ActivatedBy;
    global Id ActivatedById;
    global String StatusCode;
    global String CurrencyIsoCode;
    global WebStore SalesStore;
    global Id SalesStoreId;
    global String OrderNumber;
    global Decimal TotalAmount;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;

    global OrderChangeEvent () 
    {
    }
}