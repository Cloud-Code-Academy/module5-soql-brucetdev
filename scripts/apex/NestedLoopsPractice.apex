// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

    // public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
    // Query the original Opportunity Line Items

/*
Practice Nested Loops Challenge!

use case to experiment with for loops, or nested for loops

Use Case: get all of the accounts located in New York.

For Loop 1: Need to get all accounts in NY
---this gets the IDs for the Accounts

For Loop 2: Nested For Loop: 
--- this creates a list to create cases on the accounts identified above

Then need to create cases for the above accounts 
called "NY Account Appreciation" case with description "We love NY accounts"

...
Practice nested for loops (master detail relationships is a good use case for nested loops)

Accounts & Contacts - do something with them...
Pricebooks & Products
*/


// Query the Accounts to find New York Accounts
List<Account> NYAccountList = [SELECT Id, Name, BillingState FROM Account WHERE BillingState LIKE 'NY'];

// Create a list to hold the cases for New York appreciation
List<Case> NYAccountCaseAppreciation = new List<Case>();

// Loop through each New York Account
for (Account acc : NYAccountList) {
    // Create a new Case for each New York Account
    Case newCase = new Case();
    newCase.Subject = 'New York Account Appreciation';
    // Assign the Account Id to the Case's AccountId field
    newCase.AccountId = acc.Id;
    NYAccountCaseAppreciation.add(newCase);
    
    // Nested loop to relate the parent object (Account) to the child object (Case)
    for (Case c : NYAccountCaseAppreciation) {
        // Perform any additional operations related to the Case here
    }
}

// Insert the list of Cases
if (!NYAccountCaseAppreciation.isEmpty()) {
    insert NYAccountCaseAppreciation;
}

