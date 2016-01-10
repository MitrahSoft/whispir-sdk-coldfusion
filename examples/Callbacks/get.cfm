<a href="../../"><h4>Examples index</h4></a>
<cfscript>
	/*
	c = Application.WhispirClient.getCallbacks();
	writeDump( var = c, label = "All available Callbacks");

	// Get Callback by ID
	options = { "id" : c[1].getId() };
	getOne = Application.WhispirClient.getCallbacks(options);
	writeDump(var = getOne, label = "Get Callback by ID");

	// Get Callback by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getCallbacks(options);
	writeDump(var = getOne, label = "Get Callback by wrong CallbackID");

	// Get Callback by name
	options = { query : {"name" : c[1].getName()}};
	c = Application.WhispirClient.getCallbacks(options);
	writeDump(var = c, label = "Get Callback by name");
	abort; */
	
</cfscript>
<cfoutput>
	<cfset Callbacks = Application.whispirClient.getCallbacks()>
	<cfif arrayLen(Callbacks)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>URL</th>
			</tr>
			<cfloop array="#Callbacks#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getName()#</td>
					<td>#getOne.getURL()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
		
</cfoutput>