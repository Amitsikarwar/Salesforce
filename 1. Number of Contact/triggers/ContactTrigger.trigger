trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
   
   Set<Id> accidset = new Set<Id>();
    List<Account>acclist = new List<Account>();
   if(Trigger.isUpdate) {
	
     for(Contact cont:Trigger.New) {
      if(cont.AccountId !=null)
        accidset.add(cont.AccountId);   
    
     }

     for(Contact cont:Trigger.Old) {
      if(cont.AccountId !=null)
        accidset.add(cont.AccountId);   
    
     }   
   
   }else    
   if(Trigger.isDelete) {
     for(Contact cont:Trigger.Old) {
      if(cont.AccountId !=null)
        accidset.add(cont.AccountId);   
     }   
   
   }

   else
   {
     for(Contact cont:Trigger.New) {
         if(cont.AccountId !=null){
             accidset.add(cont.AccountId);  
         }
    
     }
   }
    if(accidset.size()>0){
        AggregateResult[] contactgroup =[SELECT COUNT(Id), Account.Id FROM Contact where Account.Id IN: accidset GROUP BY Account.Id];
        if(contactgroup.size()>0){
            for(AggregateResult ar:contactgroup) {
                Id accid = (ID) ar.get('Id');
                accidset.remove(accid);
                Integer count = (INTEGER)ar.get('expr0');                
                Account acc = new Account(Id=accid);               
                acc.Number_of_Contacts__c = count;
                acclist.add(acc); 
            }
        }
        if(accidset.size() > 0){
            for(id accid: accidset){
           	Account acc = new Account(Id=accid);
     
     		acc.Number_of_Contacts__c = 0;
            acclist.add(acc);
            }
        }
    }
    if (Account.getSObjectType().getDescribe().isUpdateable() &&
        Schema.sObjectType.Account.fields.Number_of_Contacts__c.isUpdateable()){
            update acclist;}
}