// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class WebStore {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    /* The currency to use when the buyer account’s currency isn’t supported. This value comes from your org's default for currency locale.
    */
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
    /* The language to use when translated content isn't available. This value comes from the first supported language for your org in Translation Workbench.
    */
    global String DefaultLanguage;
    /* The languages to make available to buyers. Language options come from Translation Workbench.
    */
    global String SupportedLanguages;
    /* Sets the maximum number of values to show per facet on product search results.
    */
    global Integer MaxValuesPerFacet;
    /* Sets the number of products to show on each search results page.
    */
    global Integer PaginationSize;
    /* Displays a price book with a product’s original list price and the buyer’s discounted price.
    */
    global Pricebook2 StrikethroughPricebook;
    /* Displays a price book with a product’s original list price and the buyer’s discounted price.
    */
    global Id StrikethroughPricebookId;
    /* The currencies to make available to buyers. Options come from the currencies that are supported by your org.
    */
    global String SupportedCurrencies;
    global Location Location;
    global Id LocationId;
    global String Description;
    global List<Order> Orders;
    global List<WebStoreCatalog> WebStoreCatalogs;
    global List<WebStorePricebook> WebStorePricebooks;
    global List<FlowRecordRelation> RelatedRecord;
    global List<OrderChangeEvent> SalesStore;
    global List<WebCart> WebStore;

    global WebStore () 
    {
    }
}