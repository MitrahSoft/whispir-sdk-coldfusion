<cfscript>
	/* 
	// Get contact by workspaceID
	w = Application.WhispirClient.getWorkspaces();
	options = { "workspaceId" : w[1].getId() };
	m = Application.WhispirClient.getContacts(options);
	writeDump(var = m, label = "Get contact by workspaceID");
	
	// Get all contacts from default workspace
	m = Application.WhispirClient.getContacts();
	writeDump(var = m, label = "Get all contacts from default workspace");
	
	options = {};
	if (arrayLen(m))	
		options = { "id" : m[1].getId() };
	m = Application.WhispirClient.getContacts(options);
	writeDump(var = m, label = "Get contact by contactID");

	// Get contact by wrong contactID
	options = {"id":"xxx"};
	m = Application.WhispirClient.getContacts(options);
	writeDump(var = m, label = "Get contact by wrong contactID");
	
	// Get contact by first name
	options = { query : {"firstName" : "John"}};
	m = Application.WhispirClient.getContacts(options);
	writeDump(var = m, label = "Get contact by first name");
	abort; */
</cfscript>
<cfoutput>
	<a href="../../"><h4>Examples index</h4></a>
	<cfset contact = Application.whispirClient.getContacts()>
	<cfif arrayLen(contact)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Status</th>
			</tr>
			<cfloop array="#contact#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getFirstName()#</td>
					<td>#getOne.getLastName()#</td>
					<td>#getOne.getStatus()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		<h3>No records found</h3>
	</cfif>
</cfoutput>