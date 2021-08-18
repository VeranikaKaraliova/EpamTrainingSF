@IsTest
public class AccountHTTPHelperTest {
    static final String TEST_REQUEST_BODY = '{"name": "Nika", "phone": "111"}';
	static final String TEST_ID = '0015g00000EfDiQAAV';
    
	@isTest 
    static void testGetRecordTest(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AccountHTTPHelper.getAccount('0015g00000EfDiQAAV');

        System.assertNotEquals(null, result);
        System.assertEquals(200, result.getStatusCode());
    }

    @isTest 
    static void testAddAccount(){
        AccountHTTPHelper.NewAccountRequestWrapper acc = new AccountHTTPHelper.NewAccountRequestWrapper();
        acc.name = 'TestAcc8';
        acc.phone = '888';
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        HttpResponse result = AccountHTTPHelper.addAccount(acc);
        String actualValue = result.getBody();
        String expectedValue = '{"name": "TestAcc8", "phone": "888"}';

        System.assertEquals(expectedValue, actualValue);
    }

    @isTest 
    static void testDeleteAccount(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AccountHTTPHelper.deleteAccount(TEST_ID);
        List <Account> listAcc = [SELECT ID FROM Account WHERE id =:TEST_ID];

        System.assertEquals(0, listAcc.size());
        
    }
    @isTest 
    static void testUpsertAccount(){
        AccountHTTPHelper.UpAccountRequestWrapper acc = new AccountHTTPHelper.UpAccountRequestWrapper();
        acc.name = 'TestAcc8';
        acc.phone = '888';
        acc.id = TEST_ID;
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AccountHTTPHelper.upsertAccount(acc);

        System.assertNotEquals(null, result);
        System.assertEquals(200, result.getStatusCode());
    }
    
    @isTest 
    static void testUpdateAccount(){
        AccountHTTPHelper.UpAccountRequestWrapper acc = new AccountHTTPHelper.UpAccountRequestWrapper();
        acc.name = 'TestAcc8';
        acc.phone = '888';
        acc.id = TEST_ID;
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AccountHTTPHelper.updateAccount(TEST_ID, acc);
        
        System.assertNotEquals(null, result);
        System.assertEquals(200, result.getStatusCode());
    }
}