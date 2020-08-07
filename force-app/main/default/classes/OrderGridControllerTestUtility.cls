@isTest
public class OrderGridControllerTestUtility{
    public static Map<String, String> createTestRecords(){
        String productId = createProduct();
        String pbId = createPriceBook();
        String pbeIdStandard = createPriceBookEntry(productId, Test.getStandardPricebookId());
        String pbeId = createPriceBookEntry(productId, pbId);
        String accountId = createAccount();
        String userId = createAdminUser();
        String orderId = createOrder(accountId, pbId, userId);
        String orderProductId = createOrderProduct(orderId, productId, pbeId);

        Map<String, String> recordIdMap = new Map<String,String>();
        recordIdMap.put('accountId', accountId);
        recordIdMap.put('productId', productId);
        recordIdMap.put('orderId', orderId);
        recordIdMap.put('orderProductId', orderProductId);
        recordIdMap.put('userId', userId);
        return recordIdMap;
    }

    private static String createProduct(){
        Product2 product = new Product2();
        product.Name = 'test product 1231897';
        product.StockKeepingUnit = 'test';
        product.CurrencyIsoCode = 'USD';
        product.IsActive = true;
        insert product;

        return product.Id;
    }

    private static String createPriceBook(){
        Pricebook2 pb = new Pricebook2();
        pb.Name = 'test price book';
        pb.IsActive = true;
        insert pb;

        return pb.Id;
    }

    private static String createPriceBookEntry(String productId, String pbId){
        PricebookEntry pbe = new PricebookEntry();
        pbe.CurrencyIsoCode = 'USD';
        pbe.Product2Id = productId;
        pbe.Pricebook2Id = pbId;
        pbe.IsActive = true;
        pbe.UnitPrice = 5.00;
        pbe.UseStandardPrice = false;
        insert pbe;

        return pbe.Id;
    }

    private static String createAccount(){
        Account account = new Account();
        account.Name = 'Test Account';
        account.CurrencyIsoCode = 'USD';
        insert account;

        return account.Id;
    }

    private static String createAdminUser(){
        // Create a unique UserName
        String uniqueUserName = 'SystemAdministrator' + DateTime.now().getTime() + '@testorg.com';
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User user = new User(Alias = 'sysadmin', 
                             Email ='sysadmin@testorg.com',
                             EmailEncodingKey ='UTF-8',
                             LastName ='Testing',
                             LanguageLocaleKey ='en_US',
                             LocaleSidKey ='en_US',
                             ProfileId = p.Id,
                             TimeZoneSidKey ='America/Los_Angeles',
                             UserName = uniqueUserName);
        
        insert user;

        return user.Id;
    }

    public static User createStandardUser(){
        // Create a unique UserName
        String uniqueUserName = 'StandardUser' + DateTime.now().getTime() + '@testorg.com';
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User user = new User(Alias = 'stduser', 
                             Email ='stduser@testorg.com',
                             EmailEncodingKey ='UTF-8',
                             LastName ='Testing',
                             LanguageLocaleKey ='en_US',
                             LocaleSidKey ='en_US',
                             ProfileId = p.Id,
                             TimeZoneSidKey ='America/Los_Angeles',
                             UserName = uniqueUserName);
        
        insert user;

        return user;
    }

    private static String createOrder(String accountId, String pbId, String userId){
        Order order = new Order();
        order.AccountId = accountId;
        order.CurrencyIsoCode = 'USD';
        order.Status = 'Draft';
        order.EffectiveDate = System.Today();
        order.OrderedDate = System.now();
        order.Pricebook2Id = pbId;
        order.OwnerId = userId;
        insert order;

        return order.Id;
    }

    private static String createOrderProduct(String orderId, String productId, String pbeId){
        OrderItem op = new OrderItem();
        op.OrderId = orderId;
        op.Product2Id = productId;
        op.PricebookEntryId = pbeId;
        op.Quantity = 1;
        op.UnitPrice = 5.00;
        insert op;

        return op.Id;
    }

    private static String createStore(){
        WebStore store = new WebStore();
        store.name = 'test store';
        store.CurrencyIsoCode = 'USD';
        store.DefaultLanguage = 'en_US';
        store.SupportedLanguages = 'en_US';
        insert store;

        return store.Id;
    }

    public static List<ConnectApi.ProductDetail> getProductsTest(String productId){
        List<ConnectApi.ProductDetail> products = new List<ConnectApi.ProductDetail>();

        ConnectApi.ProductDetail product = new ConnectApi.ProductDetail();
        product.Id = productId;
        ConnectApi.ProductMedia pm = new ConnectApi.ProductMedia();
        pm.url = '';
        product.defaultImage = pm;

        products.add(product);

        return products;
    }
}