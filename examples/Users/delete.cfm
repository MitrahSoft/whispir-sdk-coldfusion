<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		User = Application.WhispirClient.getUsers();
		// Delete first one, if we have more than 1 item. Deleting last item may cause issue
		if (arrayLen(User) gt 1){ 
			writeoutput('Deleting first User : #User[1].getFirstName()# <br>');
			//result = User[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(User) eq 1)
				writeoutput('only one user is available. Deleting last user may cause issue');
			else	
				writeoutput('There is no User available');
		}
	</cfscript>
</cfoutput>