public with sharing class orderGridController{
    @AuraEnabled(cacheable=true)
    public static List<OrderProductWrapper> getOrderProducts(String communityId, String effectiveAccountId, String productIdTest){
        if((communityId == null || effectiveAccountId == null) && productIdTest == null){
            return null;
        }

        if(!canReadOrderProducts() || !canReadOrders() || !canReadProducts() || !canReadWebStoreNetworks()){
            return null;
        }

        System.debug('communityId: ' + communityId + ' effectiveAccountId: ' + effectiveAccountId);

        Id currentUserId = UserInfo.getUserId();

        List<OrderItem> orderProducts = [SELECT Id,
                                                Order.Id,
                                                Order.OrderedDate,
                                                Product2.Id,
                                                Product2.Name,
                                                Product2.StockKeepingUnit,
                                                Quantity
                                            FROM OrderItem
                                            WHERE Order.OwnerId = :currentUserId
                                            ORDER BY Order.OrderedDate ASC];
        
        List<OrderProductWrapper> orderProductWrappers = new List<OrderProductWrapper>();
        List<OrderProductWrapper> orderProductWrappersTwo = new List<OrderProductWrapper>();
        
        if(orderProducts.size() > 0){
            Set<String> productIds = new Set<String>();

            for(OrderItem op: orderProducts){
                OrderProductWrapper opw = new OrderProductWrapper();
                opw.Id = op.Id;
                opw.orderId = op.Order.Id;
                opw.orderedDate = op.Order.OrderedDate;
                opw.productId = op.Product2.Id;
                opw.productName = op.Product2.Name;
                opw.productSKU = op.Product2.StockKeepingUnit;
                opw.quantity = op.Quantity;
                opw.productImageURL = null;
                orderProductWrappers.add(opw);

                productIds.add((String)op.Product2.Id);
            }

            String baseURL = getURLBase();
            List<String> productIdList = new List<String>(productIds); 
            List<ConnectApi.ProductDetail> products = new List<ConnectApi.ProductDetail>();
            String webstoreId = getStoreId(communityId);

            if(Test.isRunningTest()){
                products = OrderGridControllerTestUtility.getProductsTest(productIdTest);
            }
            else{   
                products = getProducts(productIdList, webstoreId, effectiveAccountId);
            }
                   
            for(Integer i = 0; i < orderProductWrappers.size(); i++){
                Boolean productFound = false;
                OrderProductWrapper opw = orderProductWrappers[i];
                for(ConnectApi.ProductDetail product : products){
                    if(product.id == opw.productId){
                        if(product.defaultImage.url != null){
                            opw.productImageURL = baseURL + product.defaultImage.url;
                        }
                        productFound = true;
                        break;
                    }
                }

                if(productFound == true){
                    orderProductWrappersTwo.add(opw);
                }
            }
        }
        
        return orderProductWrappersTwo;
    }

    public static String getStoreId(String communityId){
        if(communityId == null){
            return null;
        }

        return [SELECT WebStoreId FROM WebStoreNetwork WHERE NetworkId = :communityId LIMIT 1].WebStoreId;
    }

    public static List<ConnectApi.ProductDetail> getProducts(List<String> productIdList, String webstoreId, String effectiveAccountId){
        List<ConnectApi.ProductDetail> products = new List<ConnectApi.ProductDetail>();

        for(String productId : productIdList){
            try{
                ConnectApi.ProductDetail product = ConnectApi.CommerceCatalog.getProduct(webstoreId, productId, effectiveAccountId, null, false, null, false, false, true);
                products.add(product);
            }
            catch(ConnectApi.ConnectApiException e){
                System.debug('ConnectApi.CommerceCatalog.getProduct ConnectApiException: ' + e);
            }
            catch(ConnectApi.NotFoundException e){
                System.debug('ConnectApi.CommerceCatalog.getProduct NotFoundException: ' + e);
            }
            catch(ConnectApi.RateLimitException e){
                System.debug('ConnectApi.CommerceCatalog.getProduct RateLimitException: ' + e);
            }
        }

        return products;
    }

    @AuraEnabled
    public static String addToCart(String productsJSON, String communityId, String effectiveAccountId){
        String webstoreId = getStoreId(communityId);

        List<Object> cartProducts = (List<Object>)JSON.deserializeUntyped(productsJSON);
        List<ConnectApi.BatchInput> batchInputList = new List<ConnectApi.BatchInput>();
        List<ConnectApi.CartItemInput> cartItems = new List<ConnectApi.CartItemInput>();

        for(Object cartProduct : cartProducts){
            Map<String, Object> cpObjectMap = (Map<String, Object>)cartProduct;
            ConnectApi.CartItemInput cartItem = new ConnectApi.CartItemInput();
            cartItem.productId = (String)cpObjectMap.get('productId');
            Integer quantity = (Integer)cpObjectMap.get('quantity');
            cartItem.quantity = quantity.format();
            cartItem.type = ConnectApi.CartItemType.Product;
            cartItems.add(cartItem);

            ConnectApi.BatchInput batchInput = new ConnectApi.BatchInput(cartItem);
            batchInputList.add(batchInput);
        }

        if(!Test.isRunningTest()){
            try{
                List<ConnectApi.BatchResult> batchResults = ConnectApi.CommerceCart.addItemsToCart(webstoreId, effectiveAccountId, 'active', batchInputList);
                System.debug('batchResults: ' + batchResults);
            }
            catch(ConnectApi.ConnectApiException e){
                System.debug('ConnectApi.CommerceCart.addItemsToCart ConnectApiException: ' + e);
            }
            catch(ConnectApi.NotFoundException e){
                System.debug('ConnectApi.CommerceCart.addItemsToCart NotFoundException: ' + e);
            }
            catch(ConnectApi.RateLimitException e){
                System.debug('ConnectApi.CommerceCart.addItemsToCart RateLimitException: ' + e);
            }
        }

        String cartItemsString = JSON.serialize(cartItems);
        System.debug('cartItemsString: ' + cartItemsString);
        return cartItemsString;
        // return 'success';
    }

    public static String getURLBase(){
        //Domain domain = [SELECT Domain FROM Domain];
        //https://sfb2bcompcp--c.documentforce.com/cms/media/RcNgD9nFCq.RXuuctlYoQLo2VHsDjGaAU5uBN7XaXPY=

        List<Domain__mdt> domains = [SELECT Id, DeveloperName, Domain__c FROM Domain__mdt WHERE DeveloperName = 'My_Domain'];
        String domain = domains.get(0).Domain__c;
    
        String baseURL = 'https://' + domain + '--c.documentforce.com';
        return baseURL;
    }

    private static Boolean canReadOrderProducts(){
        Boolean canReadOrderProducts = false;
        if(Schema.sObjectType.OrderItem.fields.Quantity.isAccessible()){
            canReadOrderProducts = true;
        }
        return canReadOrderProducts;
    }

    private static Boolean canReadOrders(){
        Boolean canReadOrders = false;
        if(Schema.sObjectType.Order.fields.OrderedDate.isAccessible() &&
           Schema.sObjectType.Order.fields.OwnerId.isAccessible()){
            canReadOrders = true;
        }
        return canReadOrders;
    }

    private static Boolean canReadProducts(){
        Boolean canReadProducts = false;
        if(Schema.sObjectType.Product2.fields.Name.isAccessible() &&
           Schema.sObjectType.Product2.fields.StockKeepingUnit.isAccessible()){
            canReadProducts = true;
        }
        return canReadProducts;
    }

    private static Boolean canReadWebStoreNetworks(){
        Boolean canReadWebStoreNetworks = false;
        if(Schema.sObjectType.WebStoreNetwork.fields.WebStoreId.isAccessible() &&
           Schema.sObjectType.WebStoreNetwork.fields.NetworkId.isAccessible()){
            canReadWebStoreNetworks = true;
        }
        return canReadWebStoreNetworks;
    }
}