public class CartProductWrapper{
    @AuraEnabled
    public String productId{get;set;}

    @AuraEnabled
    public Integer quantity{get;set;}
}