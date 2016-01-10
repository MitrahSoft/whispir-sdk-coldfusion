<cfscript>
	/*
	// Get all messages by workspaceId
	w = Application.WhispirClient.getWorkspaces();
	options = { "workspaceId" : w[1].getId() };
	m = Application.WhispirClient.getMessages(options);
	writeDump( var = m, label = "Get available messages by workspaceId");

	// Get all messages
	m = Application.WhispirClient.getMessages();
	writeDump( var = m, label = "All available messages");

	if ( arrayLen(m) ){
		// Get message by ID
		options = { "id" : m[1].getId() };
		m = Application.WhispirClient.getMessages(options);
		writeDump(var = m, label = "Get message by ID");
	}

	// Get message by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getMessages(options);
	writeDump(var = getOne, label = "Get message by wrong messageID");
	abort; */

</cfscript>
<cfoutput>
	<a href="../../"><h4>Examples index</h4></a>
	<cfset getMessage = Application.WhispirClient.getMessages()>
	<cfif arrayLen(getMessage)>
		<table border="1">
			<tr>
				<th>Message ID</th>
				<th>Subject</th>
			</tr>
			<cfloop array="#getMessage#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getSubject()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>