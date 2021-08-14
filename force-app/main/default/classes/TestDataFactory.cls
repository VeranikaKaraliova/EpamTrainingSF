@IsTest
public class TestDataFactory {
	public static TestAccountFactory ACCOUNT = new TestAccountFactory();
    
    public class TestAccountFactory{
        public Account creatAccData(String name, Boolean needInsert){
            Account acc = new Account();
            acc.Name = name;
            if(needInsert) insert acc;
            return acc;
        }
        
        public List<Account> creatListAccData(Integer count, String name, Boolean needInsert){
            List<Account> acc = new List<Account>();
            for(Integer i = 0; i<= count; i++){
                acc.add(creatAccData(name, false));
            }
            if(needInsert) insert acc;
            return acc;
        }
    }
}
