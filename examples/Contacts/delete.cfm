<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		contactsArray = Application.whispirClient.getContacts();
		if (arrayLen(contactsArray) gt 1){ // Delete first one, if we have more than 1 item. Deleting last item may cause issue
			writeoutput('Deleting first contact : #contactsArray[1].getFirstName()# #contactsArray[1].getLastName()# <br>');
			result = contactsArray[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(contactsArray) eq 1)
				writeoutput('only one contact is available. Deleting last contact may cause issue');
			else	
				writeoutput('There is no contacts available');
		}
	</cfscript>
</cfoutput>