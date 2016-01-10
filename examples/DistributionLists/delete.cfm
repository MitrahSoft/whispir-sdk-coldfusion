<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript> 
		distributionList = Application.whispirClient.getDistributionLists();
		if (arrayLen(distributionList) gt 1){ // Delete first one, if we have more than 1 item. Deleting last item may cause issue
			writeoutput('Deleting first distribution List : #distributionList[1].getName()# <br>');
			result = distributionList[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(distributionList) eq 1)
				writeoutput('only one distribution List is available. Deleting last distribution List may cause issue');
			else	
				writeoutput('There is no distribution List available');
		}
	</cfscript>
</cfoutput>