<cfscript>
	/*
	u = Application.WhispirClient.getUsers();
	writeDump( var = u, label = "All available Users");

	// Get User by ID
	options = { "id" : u[1].getId() };
	getOne = Application.WhispirClient.getUsers(options);
	writeDump(var = getOne, label = "Get User by ID");

	// Get User by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getUsers(options);
	writeDump(var = getOne, label = "Get User by wrong UserID");

	// Get User by name
	options = { query : {"firstName" : u[1].getFirstName()}};
	getByName = Application.WhispirClient.getUsers(options);
	writeDump(var = getByName, label = "Get User by name");
	abort;
	 */
</cfscript>
<cfoutput>
	<a href="../../"><h4>Examples index</h4></a>
	<cfset User = Application.WhispirClient.getUsers()>
	<cfif arrayLen(User)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Work Email Address1</th>
				<th>Work Mobile Phone1</th>
			</tr>
			<cfloop array="#User#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getFirstName()#</td>
					<td>#getOne.getLastName()#</td>
					<td>#getOne.getWorkEmailAddress1()#</td>
					<td>#getOne.getWorkMobilePhone1()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>