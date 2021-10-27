public class SpringSOAController {
    @AuraEnabled
    public static List<Account> getaccountdata(){
        List<Account> acclist= new List<Account>();
        if(Account.getSObjectType().getDescribe().isAccessible() &&
           Schema.sObjectType.Account.fields.Name.isAccessible() &&
           Schema.sObjectType.Account.fields.AccountNumber.isAccessible() && Schema.sObjectType.Account.fields.AnnualRevenue.isAccessible()){
               acclist=[Select Name,AccountNumber,AnnualRevenue,CreatedDate from Account ORDER By CreatedDate Asc Limit 10];
           }
        return acclist;
    }

}