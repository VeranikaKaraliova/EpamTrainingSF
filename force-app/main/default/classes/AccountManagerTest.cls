@IsTest
public class AccountManagerTest {

    @isTest 
    static void testGetRecord(){
        Account acc = TestDataFactory.ACCOUNT.creatAccData('Nika', true);

        RestRequest request = new RestRequest();
        request.requestURI = 'callout:MyNamedCredentials/services/apexrest/Account/' + acc.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Account thisAcc = AccountManager.getRecord();

        System.assert(thisAcc != null);
    }

    @isTest 
    static void testCreateAcc(){
		ID thisId = AccountManager.createAcc('Nika', '11111');
		System.assertNotEquals(null, thisId);

        Account thisAcc = [SELECT Id, Name, Phone 
                           FROM Account 
                           WHERE Id =: thisId];
                           
        System.assert(thisAcc != null);
        System.assertEquals(thisAcc.Name, 'Nika');
    }

    @isTest 
    static void deleteAccTest(){
		Account acc = TestDataFactory.ACCOUNT.creatAccData('Nika', true);

		RestRequest request = new RestRequest();
        request.requestURI = 'callout:MyNamedCredentials/services/apexrest/Account/' + acc.Id;
		request.httpMethod = 'GET';
        RestContext.request = request;

        AccountManager.deleteAcc();

        List <Account> listAcc = [SELECT Id 
                                  FROM Account
                                  WHERE Id=:acc.Id];

        System.assertEquals(listAcc.size(), 0);
    }

    @isTest 
    static void upsertAccTest1(){
        ID thisId = AccountManager.upsertAcc('Nika', '11111', null);
        System.assertNotEquals(null, thisId);

        Account thisAcc = [SELECT Id, Name, Phone 
                           FROM Account 
                           WHERE Id =: thisId];

        System.assert(thisAcc != null);
        System.assertEquals(thisAcc.Name, 'Nika');
    }

    @isTest 
    static void upsertAccTest2(){
        ID thisId = AccountManager.upsertAcc('Nika', '333', '0015g00000N5bqSAAR');
        System.assertNotEquals(null, thisId);

        Account thisAcc = [SELECT Id, Name, Phone 
                           FROM Account 
                           WHERE Id =: thisId];

        System.assertEquals('333', thisAcc.Phone);
        System.assertEquals(thisId, thisAcc.Id);
    }

    @isTest 
    static void updateAccFieldsTest(){
        Account acc = TestDataFactory.ACCOUNT.creatAccData('Nika', true);

        RestRequest request = new RestRequest();
        request.requestURI = 'callout:MyNamedCredentials/services/apexrest/Account/'+acc.Id;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json;charset=UTF-8');
        request.requestBody = Blob.valueOf('{"Name":"Nata"}');
        RestContext.request = request;

        Id updateAccId = AccountManager.updateAccFields();
        System.assertNotEquals(null, updateAccId);
        
        Account thisAcc = [SELECT Id, Name 
                           FROM Account 
                           WHERE Id =: updateAccId];
                           
        System.assertEquals('Nata', thisAcc.Name);
    }

}