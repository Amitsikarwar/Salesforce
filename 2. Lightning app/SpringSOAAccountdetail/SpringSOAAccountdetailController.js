({
	init : function(component, event, helper) {
        var action = component.get("c.getaccountdata");
  		component.set('v.columns', [
            {label: 'Account name', fieldName: 'accountName', type: 'text'},
            {label: 'Account Number', fieldName: 'AccountNumber', type: 'Number'},
            {label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'Number'},
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'Date'}]);
        	action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.data",response.getReturnValue());
            }else if (response.getState() === 'ERROR') {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                this.showToast("Error ","error", "sticky", errors[0].message);
                            }
                        } else {
                            this.showToast("Error","error", "sticky", "Unknown error");
                        }
                    } else {
                        this.showToast("Error", "error", "sticky", "Please check with your admin"); 
                    }
                });
                $A.enqueueAction(action);
		
	}
})