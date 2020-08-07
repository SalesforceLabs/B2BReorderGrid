public class OrderProductWrapper{
    @AuraEnabled
    public String Id{get;set;}

    @AuraEnabled
    public String orderId{get;set;}

    @AuraEnabled
    public Datetime orderedDate{get;set;}

    @AuraEnabled
    public String productId{get;set;}

    @AuraEnabled
    public String productName{get;set;}

    @AuraEnabled
    public String productSKU{get;set;}

    @AuraEnabled
    public Decimal quantity{get;set;}

    @AuraEnabled
    public String productImageURL{get;set;}
}