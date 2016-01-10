<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		responseRules = Application.WhispirClient.getResponseRules();
		if (arrayLen(responseRules) gt 1){ // Delete first one, if we have more than 1 item. Deleting last item may cause issue
			writeoutput('Deleting first response rules : #responseRules[1].getName()# <br>');
			result = responseRules[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(responseRules) eq 1)
				writeoutput('only one response rule is available. Deleting last response rule may cause issue');
			else	
				writeoutput('There is no response rules available');
		}
	</cfscript>
</cfoutput>