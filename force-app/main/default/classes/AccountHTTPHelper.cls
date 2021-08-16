public with sharing class AccountHTTPHelper {

    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
    public class NewAccountRequestWrapper {
        public String name {get; set;}
        public String phone {get; set;}
        public String idAcc {get; set;}
    }

    public class AccRecords {
        public String id;
        public String Name;
        public String Phone;
    }
 
    public static void getAccount(Id accId) {
 
        request = new HttpRequest();
        request.setMethod('GET');
        String endpointURL = 'callout:MyNamedCredentials/services/apexrest/Account/'; 
        request.setEndpoint(endpointURL + accId);
 
        response = http.send(request); 
        AccRecords jsonAcc = (AccRecords) JSON.deserialize(response.getBody(), AccRecords.class);
        System.debug('Request:' + request);
        System.debug('Response:' + response);
        System.debug(response.getBody());
        System.debug('jsonAcc' + jsonAcc);
    }

    public static void addAccount(NewAccountRequestWrapper newAccount) {
 
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:MyNamedCredentials/services/apexrest/Account/');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
 
        response = http.send(request); 
        
        System.debug(response.getBody());
    }

    public static void deleteAccount(Id accId) {
 
        request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('callout:MyNamedCredentials/services/apexrest/Account/' + accId);
 
        response = http.send(request); 
        
        System.debug('request' + request);
        System.debug(response.getBody());
    }

    public static void upsertAccount(NewAccountRequestWrapper upAccount) {
 
        request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint('callout:MyNamedCredentials/services/apexrest/Account/');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(upAccount));
 
        response = http.send(request); 
        
        System.debug(response.getBody());
    }
    
}
