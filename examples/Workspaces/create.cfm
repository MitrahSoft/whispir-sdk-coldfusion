<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		workSpace = Application.whispirClient.create('workSpace');
		workSpace.setProjectName("new workSpace");
		workSpace.setprojectNumber("");
		workSpace.setStatus("A");
		workSpace.setbillingcostcentre("");
		getResult = workSpace.save();
		
		if(structKeyExists(getResult.fileContent, "errorText")){
			writeOutput("<h1>Error</h1>");
			writeDump(var = getResult.fileContent, label="Error");
		} else {
			writeoutput('<h1>WorkSpace Created</h1>');
			writeDump(var = getResult, label="Workspace save result");
		}
	</cfscript>
</cfoutput>