@isTest
private class OrderGridControllerTest{
    @isTest
    static void getOrderProductsTest(){
        Map<String, String> recordIdMap = OrderGridControllerTestUtility.createTestRecords();

        Product2 product = [SELECT Id, Name, StockKeepingUnit FROM Product2 WHERE Id = :recordIdMap.get('productId') LIMIT 1];
        Order order = [SELECT Id, OrderedDate FROM Order WHERE Id = :recordIdMap.get('orderId') LIMIT 1];
        OrderItem orderProduct = [SELECT Id, Quantity FROM OrderItem WHERE Id = :recordIdMap.get('orderProductId') LIMIT 1];

        OrderProductWrapper opw = new OrderProductWrapper();
        opw.Id = orderProduct.Id;
        opw.orderId = order.Id;
        opw.orderedDate = order.OrderedDate;
        opw.productId = product.Id;
        opw.productName = product.Name;
        opw.productSKU = product.StockKeepingUnit;
        opw.quantity = orderProduct.Quantity;
        opw.productImageURL = orderGridController.getURLBase();

        List<OrderProductWrapper> opwList = new List<OrderProductWrapper>();
        opwList.add(opw);

        List<OrderProductWrapper> opwListFromMethod = new List<OrderProductWrapper>();

        User user = [SELECT Id FROM User WHERE Id = :recordIdMap.get('userId') LIMIT 1];

        System.runAs(user){
            Test.startTest();
                opwListFromMethod = orderGridController.getOrderProducts(null, null, product.Id);
            Test.stopTest();
        }

        System.assertEquals(opwList[0].Id, opwListFromMethod[0].Id);
        System.assertEquals(opwList[0].orderId, opwListFromMethod[0].orderId);
        System.assertEquals(opwList[0].orderedDate, opwListFromMethod[0].orderedDate);
        System.assertEquals(opwList[0].productId, opwListFromMethod[0].productId);
        System.assertEquals(opwList[0].productName, opwListFromMethod[0].productName);
        System.assertEquals(opwList[0].productSKU, opwListFromMethod[0].productSKU);
        System.assertEquals(opwList[0].quantity, opwListFromMethod[0].quantity);
        System.assertEquals(opwList[0].productImageURL, opwListFromMethod[0].productImageURL);
    }

    @isTest
    static void getOrderProductsNullTest(){
        Test.startTest();
            List<OrderProductWrapper> opwList = orderGridController.getOrderProducts(null, null, null);
        Test.stopTest();

        System.assertEquals(null, opwList);
    }

    // @isTest
    // static void addToCartTest(){
    //     List<CartProductWrapper> cartProducts = new List<CartProductWrapper>();
    //     CartProductWrapper cartProduct = new CartProductWrapper();
    //     cartProduct.productId = '12345';
    //     cartProduct.quantity = 2;
    //     cartProducts.add(cartProduct);

    //     String cartProductsJSON = JSON.serialize(cartProducts);

    //     Test.startTest();
    //         List<ConnectApi.CartItemInput> cartItemInputs = orderGridController.addToCart(cartProductsJSON, null, null);
    //     Test.stopTest();

    //     System.assertEquals(cartProduct.productId, cartItemInputs[0].productId);
    //     System.assertEquals(cartProduct.quantity, Integer.valueOf(cartItemInputs[0].quantity));
    // }

    @isTest
    static void orderProductsNotAccessibleTest(){
        User standardUser = OrderGridControllerTestUtility.createStandardUser();

        List<OrderProductWrapper> opwList = new List<OrderProductWrapper>();

        System.runAs(standardUser){
            Test.startTest();
                opwList = orderGridController.getOrderProducts(null, null, '12345');
            Test.stopTest();
        }

        System.assertEquals(null, opwList);
    }
}