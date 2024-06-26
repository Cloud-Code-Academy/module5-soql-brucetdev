/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Bruce Harpham
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads(){
    List <Lead> getAllLeads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
    return getAllLeads;
    }


       
     /* Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getAllContactsWithFirstNameJohn(){
    List <Contact> allJohnContacts = [SELECT Id, Name FROM CONTACT WHERE Firstname = 'John'];
    return allJohnContacts;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName(){
      List<Id> contactIds = new List<Id>();
      for (Contact c : [SELECT Id FROM Contact WHERE Lastname IN ('Smith', 'Jones')]) {
        contactIds.add(c.Id);
    }
    return contactIds;
}

    
     /* Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    // public static List<Id> getContactIdsByLastName(){
    public static List<Opportunity> getClosedWonOpportunityCountByAccount(){
      List<Opportunity> opportunities = new List<Opportunity>();
      for (Opportunity o : [SELECT Id, Amount, Name, CloseDate, Stagename, Opportunity.AccountId FROM Opportunity WHERE Stagename = 'Closed Won']) {
        opportunities.add(o);
    }
    return opportunities;
}
    
    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
  public static Integer getAccountCount(){
    return [SELECT COUNT() FROM Account];
  }
//}

    
     /* Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<ID, Task> getTasksWithDueDates() {
      Map<ID, Task> taskMap = new Map<ID, Task>(); // Changed to Map<ID, Task>
      List<Task> tasks = [SELECT ID, ActivityDate FROM Task WHERE ActivityDate <= NEXT_N_DAYS:7];
      for (Task t : tasks) {
          taskMap.put(t.Id, t); // Put the entire Task object into the map
      }
      return taskMap;
  }
  
    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List <Contact>getContactsByEmailDomain(){
      List<Contact> contactList = new List<Contact>();
      for (contact con : [SELECT Id, Email, Name FROM Contact WHERE Email LIKE '%example.com']) {
        contactList.add(con);
    }
    return contactList;
}

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
  
     public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
      List<Opportunity> oppList = new List<Opportunity>();
      // Added a null check for the keyword parameter to prevent SOQL injection and improve flexibility
      if (keyword != null && keyword != '') {
          // Used binding to dynamically include the keyword in the SOQL query
          for (Opportunity opp : [SELECT Id, Name FROM Opportunity WHERE Name LIKE :'%'+keyword+'%']) {
              oppList.add(opp);
          }
      }
      return oppList;
  }

      /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilteredCases() {
      List<Case> caseList = new List<Case>(); 
      for (Case cs : [SELECT Id, Origin FROM Case WHERE Origin NOT IN ('Web', 'Email', '')]) {
          caseList.add(cs);
      }
      return caseList;
  }


   
    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getGetLeadsBySourceOrTitle() {
      List<Lead> leadList = new List<Lead>();

      leadList.addall([SELECT ID, Company, LastName, LeadSource, Title, Phone, Email FROM Lead WHERE LeadSource = 'Web']);
      leadlist.addall([SELECT ID, Company, LastName, LeadSource, Title, Phone, Email FROM Lead WHERE Title Like '%Engineer']);
      
      return leadList;
  }
    
    /*
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
 
public static List<String> getContactNamesByAccount(Id accountId) {
  // Create a new list to hold the Contact LastNames
  List<String> contLastNameList = new List<String>();
  // Query the Contacts
  List<Contact> allContacts = [SELECT LastName FROM Contact WHERE AccountId = :accountId];
  // Loop through each Contact and add the LastName to the list
  for (Contact con : allContacts) {
      contLastNameList.add(con.LastName);
  }
  // Return the list of Contact LastNames
  return contLastNameList;
}



    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
      // Use AggregateQuery to get the total revenue
      List<AggregateResult> totalRevenue = [SELECT SUM(Amount) totalAmount FROM Opportunity WHERE StageName = :stage OR Amount >= 10000];
      Decimal revenue = 0;
      if (!totalRevenue.isEmpty()) {
          revenue = (Decimal)totalRevenue[0].get('totalAmount');
      }
      // Return the total revenue
      return revenue;
  }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
    List<Account> first10Accounts = new List<Account>();
    first10Accounts = [SELECT Name FROM ACCOUNT ORDER BY NAME LIMIT 10];
    return first10Accounts;
    }
 
   
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
    List<Opportunity> top5Opps = new List<Opportunity>();
    top5opps =  [SELECT Name, Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5]; // AND Amount >= 100000
    return top5Opps;
    }


    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
   public static List<Contact> getBirthdateContacts() {
    List<Contact> birthdayContacts = new List<Contact>();
    birthdayContacts = [SELECT Name, ID, Birthdate FROM CONTACT ORDER BY Birthdate DESC LIMIT 3];
    return birthdayContacts;
   }
     
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
    List<Case> casesWithStatus = new List<Case>();
    casesWithStatus = [SELECT ID, Status, CreatedDate FROM Case ORDER BY CreatedDate LIMIT 10 OFFSET 5];
    return casesWithStatus;
    }
 
    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
      Set <Id> caseIdSet = new Set<Id>();
        // Query the Cases
      List<Case> myCasesList = [SELECT ID FROM Case WHERE AccountId = :accountId];
      Set<Case> myCasesSet = new Set<Case>(myCasesList);
        // Loop through each Case and add the Id to the set
       for (Case caseRec : myCasesList){
        caseIdSet.add(caseRec.Id);
       }
        return caseIdSet;
    }
   
    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountMap = new Map<Id, String>();

        // Query the Accounts
      List <Account> myAccountList = [SELECT ID, Name FROM Account WHERE BillingCountry != :country];
      // Loop through each Account and add the Id and Name to the map
      for (Account acc : myAccountList){
        accountMap.put(acc.ID, acc.Name);
      }
      return accountMap;
    }
 //       return null; // Replace null with the variable you used to store the result
  //  }

    /**
     * Question 19 
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
    Account acc = [SELECT Name FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id = :contactId) LIMIT 1];
    return acc != null ? acc.Name : null;
}

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
    Account acc = [SELECT Name, (SELECT ID, Name FROM Opportunities) FROM Account Where ID = :accountId Limit 1];
    return acc; 
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        String billingState = [SELECT BillingState FROM Account Where ID = :accountId].BillingState;
        // Store the Account's BillingState
        List<Contact> contactList = [SELECT Id, Name, MailingState FROM Contact WHERE MailingState = :billingState];
        return contactList;     
    }   
 
    /*
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
     
     public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
    Set<String> emailDomains = new Set<String>();
    
    // Query the Leads
    List<Lead> leadList = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];
    
    // Extract email domains from Leads' emails and add to the set
    for (Lead lead : leadList) {
        if (lead.Email != null) {
            String[] parts = lead.Email.split('@');
            if (parts.size() == 2) {
                emailDomains.add(parts[1].toLowerCase()); // Convert to lower case for case insensitivity
            }
        }
    }
    
    // Query the Accounts with matching website domains
    List<Account> matchingAccounts = [SELECT Id, Website FROM Account WHERE Website != null];
    
    // Filter the matching accounts based on email domains
    List<Account> filteredAccounts = new List<Account>();
    for (Account acc : matchingAccounts) {
        for (String domain : emailDomains) {
            if (acc.Website.containsIgnoreCase(domain)) {
                filteredAccounts.add(acc);
                break; // Once found, break and move to the next account
            }
        }
    }
    
    return filteredAccounts;
}

    /**
     * Question 23 - this passed with help!
     * Current status as of April 10: The test class does not pass the test class. Error message: "System.AssertException: Assertion Failed: Number of cloned line items is incorrect.: Expected: 1, Actual: 0"
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    
     public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
    // Query the original Opportunity Line Items
    List<OpportunityLineItem> origOppLineItemList = [SELECT Id, Quantity, OpportunityID, PriceBookEntryID, UnitPrice FROM OpportunityLineItem WHERE OpportunityID = :origOppId];
    System.debug('Number of original Opportunity Line Items: ' + origOppLineItemList.size());
     // there is nothing showing in the debug line above.


    // Create a list to hold the new line items
    List<OpportunityLineItem> MyClonedOpps = new List<OpportunityLineItem>();
    
    // assigns a parent id --- this is creating the master object of opportunity before creating the child object, namely opportunity line item. 
    // what is a better name for opploop1? -- parent object? 
    for (Id oppLoop1 : cloneOppIds){  // The first word here 'id' is the data type
     
    // Loop through each original line item
    for (OpportunityLineItem oli : origOppLineItemList) {
        // Generate a random number between 1 and 3 for quantity
        Integer randomNumber = Integer.valueOf(Math.random() * 3) + 1;
        System.debug('The random number between 1 and 3 is: ' + randomNumber);
        
        // Clone the original line item
        OpportunityLineItem newOli = oli.clone(false, false, false, false);
        
        // Add the random number to the quantity
        newOli.Quantity = oli.Quantity + randomNumber;
        
        // Assign parent object id to parent object id
        newOli.opportunityid = oppLoop1;
              
        // Add the cloned line item to the list
        MyClonedOpps.add(newOli);
    }
  }

    // Insert the cloned line items outside the loop
    System.debug('Number of cloned line items: ' + MyClonedOpps.size());
    insert MyClonedOpps;
    

}

  
    /**
     * Question 24 - solved question!
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
    List<Opportunity> closedWonOpps = [SELECT ID, Name, OwnerId, Account.Name FROM Opportunity WHERE Stagename = 'Closed Won'];
    return closedWonOpps;
   //     return null; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     * reference material from question 20:      public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
    Account acc = [SELECT Name, (SELECT ID, Name FROM Opportunities) FROM Account Where ID = :accountId Limit 1];
    return acc; 
    }
     */
    
     public static void setPrimaryContact() {
      // Use the getOpportunityDetailsForClosedWon() method to get the Opportunities.
      List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();
  
      // Loop through Closed Won Opportunities
      for (Opportunity opp : closedWonOpps) {
          // Query for the contact associated with the Account, ordered by first name alphabetically
          List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :opp.AccountId ORDER BY FirstName ASC LIMIT 1];
          if (!contacts.isEmpty()) {
              Contact selectedContact = contacts[0];
              // Set the 'Primary Contact' field on the Opportunity to the Id of the selected Contact
              opp.Primary_Contact__c = selectedContact.Id;
          }
      }
  
      // Update Opportunities
      update closedWonOpps;
  }
  
  
  
  
  
  
  
}