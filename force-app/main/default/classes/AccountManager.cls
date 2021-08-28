@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    @HttpGet //Read
    global static Account getRecord() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Id, Name, Phone
                        FROM Account
                        WHERE Id = :accId];
        return result;
    }

    @HttpPost //Create
    global static ID createAcc(String name, String phone) {
        Account thisAcc = new Account(
            Name=name,
            Phone=phone);
        insert thisAcc;
        return thisAcc.Id;
    }

    @HttpDelete //Delete
    global static void deleteAcc() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
            Account thisAcc = [SELECT Id FROM Account WHERE Id = :accId];
        delete thisAcc;
    } 

    @HttpPut //Upsert
    global static ID upsertAcc(String  name, String phone, String id) {
        Account thisAcc = new Account(
                Id=id,
                Name=name,
                Phone=phone);
        upsert thisAcc;
        return thisAcc.Id;
    }

    @HttpPatch //Update
    global static ID updateAccFields() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account thisAcc = [SELECT Id FROM Account WHERE Id = :accId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Account sObject
            thisAcc.put(fieldName, params.get(fieldName));
        }
        update thisAcc;
        return thisAcc.Id;
    } 

}
