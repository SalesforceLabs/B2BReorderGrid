/*
==========================================
    Title: OrderWrapper
    Purpose: Wrapper class to store orders.
    Author: Clay Phillips
    Created Date: 01/25/2021 
==========================================
*/

public with sharing class OrderWrapper{
    @AuraEnabled
    public String Id{get;set;}

    @AuraEnabled
    public Datetime orderedDate{get;set;}
}