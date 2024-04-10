// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

     public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
    // Query the original Opportunity Line Items

    List<OpportunityLineItem> origOppLineItemList = [SELECT Id, Quantity, OpportunityID, PriceBookEntryID, UnitPrice FROM OpportunityLineItem WHERE OpportunityID = :origOppId];
  System.debug('Number of original Opportunity Line Items: ' + origOppLineItemList.size());
 


    // Create a list to hold the new line items
    List<OpportunityLineItem> MyClonedOpps = new List<OpportunityLineItem>();
    
    // Loop through each original line item
    for (OpportunityLineItem oli : origOppLineItemList) {
        // Generate a random number between 1 and 3 for quantity
        Integer randomNumber = Integer.valueOf(Math.random() * 3) + 1;
        System.debug('The random number between 1 and 3 is: ' + randomNumber);
        
        // Clone the original line item
        OpportunityLineItem newOli = oli.clone(false, false, false, false);
        
        // Add the random number to the quantity
        newOli.Quantity = oli.Quantity + randomNumber;
        
        // Add the cloned line item to the list
        MyClonedOpps.add(newOli);
    }
     }
    /*
    // Insert the cloned line items outside the loop
    insert MyClonedOpps;
    
    System.debug('Number of cloned line items: ' + MyClonedOpps.size());
}
*/