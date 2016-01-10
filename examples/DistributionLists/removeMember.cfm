<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		// Get all distributionLists
		d = Application.WhispirClient.getDistributionLists();

		if ( arrayLen(d) ){

			// Add a contact to DistributionList
			m = Application.WhispirClient.getContacts();
			Options = { type : "contact", listOfID : m[1].getID() };
			result = d[1].removeMember(Options);
			writeDump( var = result, label = "A contact removed from First DistributionList" );

			// Add a user to DistributionList
			u = Application.WhispirClient.getUsers();
			Options = { type : "user", listOfID : u[1].getID() };
			result = d[1].removeMember(Options);
			writeDump( var = result, label = "A user removed from First DistributionList" );

		}else {
			writeOutput( 'No DistributionList available');
		}
		
	</cfscript>
</cfoutput>