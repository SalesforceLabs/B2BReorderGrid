// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CartItem {
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
    global CartDeliveryGroup CartDeliveryGroup;
    global Id CartDeliveryGroupId;
    global Product2 Product2;
    global Id Product2Id;
    global String Type;
    global String Sku;
    global Double Quantity;
    global Decimal ListPrice;
    global Decimal SalesPrice;
    global Decimal TotalListPrice;
    global Decimal TotalLineAmount;
    global Decimal AdjustmentAmount;
    global Decimal TotalPrice;
    global Decimal TotalLineTaxAmount;
    global Decimal AdjustmentTaxAmount;
    global Decimal TotalTaxAmount;
    global Decimal TotalAmount;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<CartRelatedItem> ChildCartItem;
    global List<CartRelatedItem> ParentCartItem;
    global List<FlowRecordRelation> RelatedRecord;

    global CartItem () 
    {
    }
}