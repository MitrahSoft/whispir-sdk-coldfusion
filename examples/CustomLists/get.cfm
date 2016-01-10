<a href="../../"><h4>Examples index</h4></a>
<cfscript>
	/*
	c = Application.WhispirClient.getCustomLists();
	writeDump( var = c, label = "All available CustomLists");

	// Get CustomList by ID
	options = { "id" : c[1].getId() };
	getOne = Application.WhispirClient.getCustomLists(options);
	writeDump(var = getOne, label = "Get CustomList by ID");

	// Get CustomList by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getCustomLists(options);
	writeDump(var = getOne, label = "Get CustomList by wrong CustomListID");

	// Get CustomList by name
	options = { query : {"name" : c[1].getName()}};
	getByName = Application.WhispirClient.getCustomLists(options);
	writeDump(var = getByName, label = "Get CustomList by name");
	abort; */
	
</cfscript>
<cfoutput>
	<cfset customLists = Application.WhispirClient.getCustomLists()>
	<cfif arrayLen(customLists)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Name</th>
			</tr>
			<cfloop array="#customLists#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getName()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>