@IsTest
private class RunScheduledTest {
    @IsTest
    public static void runScheduledTest(){
        
        Test.startTest();
        String jobId = System.schedule('Test', '0 30 * * * ?', new RunScheduled());
        String jobId2 = System.schedule('Test2', '0 0 * * * ?', new RunScheduled());
        Test.stopTest();
        
        System.assertNotEquals(null, jobId);
        System.assertNotEquals(null, jobId2);
    }
}
