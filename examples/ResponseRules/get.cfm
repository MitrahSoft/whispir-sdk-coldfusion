<a href="../../"><h4>Examples index</h4></a>
<cfscript>
	/*
	r = Application.WhispirClient.getResponseRules();
	writeDump( var = r, label = "All available ResponseRules");

	// Get ResponseRule by ID
	options = { "id" : r[1].getId() };
	getOne = Application.WhispirClient.getResponseRules(options);
	writeDump(var = getOne, label = "Get ResponseRule by ID");

	// Get ResponseRule by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getResponseRules(options);
	writeDump(var = getOne, label = "Get ResponseRule by wrong ResponseRule ID");
	abort;
	 */
</cfscript>
<cfoutput>
	<cfset responseRules = Application.WhispirClient.getResponseRules()>
	<cfif arrayLen(responseRules)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Name</th>
			</tr>
			<cfloop array="#responseRules#" index="getOne">
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