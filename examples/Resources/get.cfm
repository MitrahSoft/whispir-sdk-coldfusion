<a href="../../"><h4>Examples index</h4></a>
<cfscript>
	/*
	r = Application.WhispirClient.getResources();
	writeDump( var = r, label = "All available Resources");

	// Get Resource by ID
	options = { "id" : r[1].getId() };
	getOne = Application.WhispirClient.getResources(options);
	writeDump(var = getOne, label = "Get Resource by ID");

	// Get Resource by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getResources(options);
	writeDump(var = getOne, label = "Get Resource by wrong ResourceID");

	// Get Resource by name
	options = { query : {"name" : r[1].getName()}};
	getByName = Application.WhispirClient.getResources(options);
	writeDump(var = getByName, label = "Get Resource by name");
	
	//Only get the private resources
	options = { query : {"scope" : "private"}};
	getPrivate = Application.WhispirClient.getResources(options);
	writeDump(var = getPrivate, label = "Get Resource Private Scope");

	//Only get the public resources
	options = { query : {"scope" : "public"}};
	getPublic = Application.WhispirClient.getResources(options);
	writeDump(var = getPublic, label = "Get Resource public Scope");
	abort;
	 */
</cfscript>
<cfoutput>
	<cfset Resources = Application.whispirClient.getResources()>
	<cfif arrayLen(Resources)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Scope</th>
				<th>Mime Type</th>
			</tr>
			<cfloop array="#Resources#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getName()#</td>
					<td>#getOne.getScope()#</td>
					<td>#getOne.getMimeType()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>