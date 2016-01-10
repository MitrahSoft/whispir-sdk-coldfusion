<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		Scenarios = Application.whispirClient.getScenarios();
		if (arrayLen(Scenarios) gt 1){ // Delete first one, if we have more than 1 item. Deleting last item may cause issue
			writeoutput('Deleting first Scenario : #Scenarios[1].getTitle()# <br>');
			result = Scenarios[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(Scenarios) eq 1)
				writeoutput('only one Scenario is available. Deleting last Scenario may cause issue');
			else	
				writeoutput('There is no Scenario available');
		}
	</cfscript>
</cfoutput>

