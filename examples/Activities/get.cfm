<a href="../../"><h4>Examples index</h4></a>
<cfscript>
	/*
	a = Application.WhispirClient.getActivity();
	writeDump( var = a, label = "All available Activities");

	// Get Activity by ID
	options = { "id" : a[1].getId() };
	getOne = Application.WhispirClient.getActivity(options);
	writeDump(var = getOne, label = "Get Activity by ID");

	// Get Activity by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getActivity(options);
	writeDump(var = getOne, label = "Get Activity by wrong Activity D");

	// Get Activity by action
	options = { query : {"action" : "Login"}};
	a = Application.WhispirClient.getActivity(options);
	writeDump(var = a, label = "Get Activity by action");

	// Get Activity by workspaceID
	w = Application.WhispirClient.getWorkspaces();
	options = { "workspaceId" : w[1].getId() };
	a = Application.WhispirClient.getActivity(options);
	writeDump(var = a, label = "Get Activity by workspaceID");
	abort;
	 */
</cfscript>
<cfoutput>
	<cfset Activities = Application.whispirClient.getActivity()>
	<cfif arrayLen(Activities)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>module</th>
				<th>action</th>
				<th>Status</th>
				<th>workspaceName</th>
				<th>description</th>
				<th>user</th>
			</tr>
			<cfloop array="#Activities#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getModule()#</td>
					<td>#getOne.getAction()#</td>
					<td>#getOne.getStatus()#</td>
					<td>#getOne.getWorkspaceName()#</td>
					<td>#getOne.getDescription()#</td>
					<td>#getOne.getUser()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>

</cfoutput>