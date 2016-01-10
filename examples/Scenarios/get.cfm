<cfscript>
	/*
	s = Application.WhispirClient.getScenarios();
	writeDump( var = s, label = "All available Scenarios");

	// Get Scenario by ID
	options = { "id" : s[1].getId() };
	s = Application.WhispirClient.getScenarios(options);
	writeDump(var = s, label = "Get Scenario by ID");

	// Get Scenario by wrong ID
	options = {"id":"xxx"};
	s = Application.WhispirClient.getScenarios(options);
	writeDump(var = s, label = "Get Scenario by wrong ScenarioID");
	abort; */
	
</cfscript>
<cfoutput>
	<a href="../../"><h4>Examples index</h4></a>
	<cfset Scenarios = Application.whispirClient.getScenarios()>
	
	<cfif arrayLen(Scenarios)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Title</th>
				<th>Description</th>
			</tr>
			<cfloop array="#Scenarios#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getTitle()#</td>
					<td>#getOne.getDescription()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>