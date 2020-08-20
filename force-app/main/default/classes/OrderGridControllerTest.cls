/*
==========================================
    Title: OrderGridControllerTest
    Purpose: Test class for
        OrderGridController. 
    Author: Clay Phillips
    Date: 08/20/2020 
==========================================
*/

@isTest
private class OrderGridControllerTest{
    //Test method to test the getOrderProducts() method in OrderGridController. 
    @isTest
    static void getOrderProductsTest(){
        //Grab test record Ids from OrderGridControllerTestUtility
        Map<String, String> recordIdMap = OrderGridControllerTestUtility.createTestRecords();

        //SOQL queries to grab the created test records.
        Product2 product = [SELECT Id, Name, StockKeepingUnit FROM Product2 WHERE Id = :recordIdMap.get('productId') LIMIT 1];
        Order order = [SELECT Id, OrderedDate FROM Order WHERE Id = :recordIdMap.get('orderId') LIMIT 1];
        OrderItem orderProduct = [SELECT Id, Quantity FROM OrderItem WHERE Id = :recordIdMap.get('orderProductId') LIMIT 1];
        User user = [SELECT Id FROM User WHERE Id = :recordIdMap.get('userId') LIMIT 1];

        //Creating a OrderProductWrapper and OPW list manually to test the return value of getOrderProducts()
        OrderProductWrapper opw = new OrderProductWrapper();
        opw.Id = orderProduct.Id;
        opw.orderId = order.Id;
        opw.orderedDate = order.OrderedDate;
        opw.productId = product.Id;
        opw.productName = product.Name;
        opw.productSKU = product.StockKeepingUnit;
        opw.quantity = orderProduct.Quantity;
        opw.productImageURL = OrderGridController.getURLBase();

        List<OrderProductWrapper> opwList = new List<OrderProductWrapper>();
        opwList.add(opw);

        //Stores the OPW list returned by getOrderProducts()
        List<OrderProductWrapper> opwListFromMethod = new List<OrderProductWrapper>();

        //Run the getOrderProducts() method as the user created in the test utility.
        System.runAs(user){
            Test.startTest();
                opwListFromMethod = OrderGridController.getOrderProducts(null, null, product.Id);
            Test.stopTest();
        }

        //Assertions to ensure the OPW returned from the getOrderProducts() method
        //is the same as the one created manually.
        System.assertEquals(opwList[0].Id, opwListFromMethod[0].Id);
        System.assertEquals(opwList[0].orderId, opwListFromMethod[0].orderId);
        System.assertEquals(opwList[0].orderedDate, opwListFromMethod[0].orderedDate);
        System.assertEquals(opwList[0].productId, opwListFromMethod[0].productId);
        System.assertEquals(opwList[0].productName, opwListFromMethod[0].productName);
        System.assertEquals(opwList[0].productSKU, opwListFromMethod[0].productSKU);
        System.assertEquals(opwList[0].quantity, opwListFromMethod[0].quantity);
        System.assertEquals(opwList[0].productImageURL, opwListFromMethod[0].productImageURL);
    }

    //Test method to test the getOrderProducts() method when it returns null because there are no order products.  
    @isTest
    static void testNoOrderProducts(){
        Test.startTest();
            List<OrderProductWrapper> opwList = OrderGridController.getOrderProducts(null, null, 'test123');
        Test.stopTest();

        System.assertEquals(null, opwList);
    }

    //Test method to test the getOrderProducts() method when it returns null since there is no
    //community, account, or test product Id.
    @isTest
    static void testNoCommunityAndAccount(){
        Test.startTest();
            List<OrderProductWrapper> opwList = OrderGridController.getOrderProducts(null, null, null);
        Test.stopTest();

        System.assertEquals(null, opwList);
    }

    //Test method to test the addToCart() method in OrderGridController.
    @isTest
    static void addToCartTest(){
        //Create a fake cartProduct to test the return value of addToCart() since
        //the ConnectApi can't be called within the test class unless SeeAllData is true which
        //would make the test not siloed.
        List<CartProductWrapper> cartProducts = new List<CartProductWrapper>();
        CartProductWrapper cartProduct = new CartProductWrapper();
        cartProduct.productId = '12345';
        cartProduct.quantity = 2;
        cartProducts.add(cartProduct);

        String cartProductsJSON = JSON.serialize(cartProducts);

        Test.startTest();
            List<CartProductWrapper> cartProductWrappers = OrderGridController.addToCart(cartProductsJSON, null, null);
        Test.stopTest();

        System.assertEquals(cartProduct.productId, cartProductWrappers[0].productId);
        System.assertEquals(cartProduct.quantity, cartProductWrappers[0].quantity);
    }

    //Test method to ensure that the methods in OrderGridController for object accessibility
    //are returning false for users who can't access those objects.
    @isTest
    static void orderProductsNotAccessibleTest(){
        User chatterUser = OrderGridControllerTestUtility.createChatterUser();

        List<OrderProductWrapper> opwList;
        Boolean canReadOrderProducts;
        Boolean canReadOrders;
        Boolean canReadProducts;
        Boolean canReadWebStoreNetworks;

        System.runAs(chatterUser){
            Test.startTest();
                opwList = OrderGridController.getOrderProducts(null, null, '12345');
                canReadOrderProducts = OrderGridController.canReadOrderProducts();
                canReadOrders = OrderGridController.canReadOrders();
                canReadProducts = OrderGridController.canReadProducts();
                canReadWebStoreNetworks = OrderGridController.canReadWebStoreNetworks();
            Test.stopTest();
        }

        System.assertEquals(null, opwList);
        System.assertEquals(false, canReadOrderProducts);
        System.assertEquals(false, canReadOrders);
        System.assertEquals(false, canReadProducts);
        System.assertEquals(false, canReadWebStoreNetworks);
    }
}