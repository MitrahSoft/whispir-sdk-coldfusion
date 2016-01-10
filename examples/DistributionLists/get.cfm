<a href="../../"><h4>Examples index</h4></a>
<cfscript>
	/*
	// Get all DistributionLists by workspaceId
	w = Application.WhispirClient.getWorkspaces();
	options = { "workspaceId" : w[1].getId() };
	d = Application.WhispirClient.getDistributionLists(options);
	writeDump( var = d, label = "Get available DistributionLists by workspaceId");

	// Get all DistributionLists
	d = Application.WhispirClient.getDistributionLists();
	writeDump( var = d, label = "All available DistributionList");
	
	// Get DistributionList by name
	options = { query : {"name" : d[1].getname()}};
	d = Application.WhispirClient.getDistributionLists(options);
	writeDump(var = d, label = "Get DistributionList by name");
	abort; */
	
	
</cfscript>
<cfoutput>
	<cfset distributionList = Application.whispirClient.getDistributionLists()>
	
	<cfif arrayLen(distributionList)>	
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Description</th>
				<th>Access</th>
				<th>Visibility</th>
			</tr>
			<cfloop array="#distributionList#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getName()#</td>
					<td>#getOne.getDescription()#</td>
					<td>#getOne.getAccess()#</td>
					<td>#getOne.getVisibility()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>