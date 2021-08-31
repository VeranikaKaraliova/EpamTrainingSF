public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodoList() {
        return [
            SELECT Name,
            Title__c,
            Priority__c,
            Category__c,
            Creation_Date__c,
            Description__c,
            Is_done__c
            FROM Todo__c
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Todo__c getTodo(ID key) {
        return [
            SELECT Name,
            Title__c,
            Priority__c,
            Category__c,
            Creation_Date__c,
            Description__c,
            Is_done__c
            FROM Todo__c
            WHERE ID =: key
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Todo__c> findeTodo(String key) {
        String searchKey= '%' + key + '%';
        return [
            SELECT Name,
            Title__c,
            Priority__c,
            Category__c,
            Creation_Date__c,
            Description__c,
            Is_done__c,
            Image__c
            FROM Todo__c
            WHERE Name LIKE : searchKey
        ];
    }
}
