/*
==========================================
    Title: OrderGridWrapper
    Purpose: Wrapper class store to the
        order products and webstore Id.
    Author: Clay Phillips
    Date: 08/24/2020 
==========================================
*/

public class OrderGridWrapper{
    @AuraEnabled
    public List<OrderProductWrapper> orderProducts{get;set;}

    @AuraEnabled
    public String webstoreId{get;set;}
}