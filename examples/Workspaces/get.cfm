<cfscript>
	/*
	w = Application.WhispirClient.getWorkspaces();
	writeDump( var = w, label = "All available workspaces");
	
	// Get workspace by ID
	options = { "id" : w[1].getId() };
	m = Application.WhispirClient.getWorkspaces(options);
	writeDump(var = m, label = "Get workspace by ID");

	// Get workspace by wrong ID
	options = {"id":"xxx"};
	m = Application.WhispirClient.getWorkspaces(options);
	writeDump(var = m, label = "Get workspace by wrong workspaceID");
	abort;
	 */
	
</cfscript>
<cfoutput>
	<a href="../../"><h4>Examples index</h4></a>
	<cfset Workspace = Application.WhispirClient.getWorkspaces()>
	<cfif arrayLen(Workspace)>
		<table border="1">
			<tr>
				<th>Workspace Id</th>
				<th>Project Name</th>
				<th>Status</th>
				<th>Billing Cost Centre</th>
			</tr>
			<cfloop array="#Workspace#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getProjectName()#</td>
					<td>#getOne.getStatus()#</td>
					<td>#getOne.getbillingcostcentre()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		<h3>No records found</h3>
	</cfif>
</cfoutput>