<cfscript>
	/*
	t = Application.WhispirClient.getTemplates();
	writeDump( var = t, label = "All available Templates");

	// Get Template by ID
	options = { "id" : t[1].getId() };
	getOne = Application.WhispirClient.getTemplates(options);
	writeDump(var = getOne, label = "Get Template by ID");

	// Get Template by wrong ID
	options = {"id":"xxx"};
	getOne = Application.WhispirClient.getTemplates(options);
	writeDump(var = getOne, label = "Get Template by wrong Template ID");
	abort; */
	
</cfscript>
<cfoutput>
	<a href="../../"><h4>Examples index</h4></a>
	<cfset Template = Application.WhispirClient.getTemplates()>
	<cfif arrayLen(Template)>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Message Template Name</th>
				<th>Message Template Description</th>
			</tr>
			<cfloop array="#Template#" index="getOne">
				<tr>
					<td>#getOne.getId()#</td>
					<td>#getOne.getMessageTemplateName()#</td>
					<td>#getOne.getMessageTemplateDescription()#</td>
				</tr>
			</cfloop>
		</table>
	<cfelse>
		No records found
	</cfif>
</cfoutput>