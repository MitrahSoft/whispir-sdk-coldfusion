<cfoutput>
	<cfscript>
		customList = Application.whispirClient.create('customList');
		Options = { query: { name : "Category" }};
		result = customList.filter(Options);
		writeDump(result);
	</cfscript>
</cfoutput>