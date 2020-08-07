// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CartDeliveryGroup {
    global Id Id;
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
    global WebCart Cart;
    global Id CartId;
    global Datetime DesiredDeliveryDate;
    global String ShippingInstructions;
    global String DeliverToName;
    global String DeliverToStreet;
    global String DeliverToCity;
    global String DeliverToState;
    global String DeliverToPostalCode;
    global String DeliverToCountry;
    global Double DeliverToLatitude;
    global Double DeliverToLongitude;
    global String DeliverToGeocodeAccuracy;
    global Address DeliverToAddress;
    global Decimal TotalProductAmount;
    global Decimal TotalChargeAmount;
    global Decimal TotalAmount;
    global Decimal TotalProductTaxAmount;
    global Decimal TotalChargeTaxAmount;
    global Decimal TotalTaxAmount;
    global Decimal GrandTotalAmount;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<CartItem> CartDeliveryGroup;
    global List<FlowRecordRelation> RelatedRecord;

    global CartDeliveryGroup () 
    {
    }
}