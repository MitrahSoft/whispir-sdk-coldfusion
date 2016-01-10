<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		Resources = Application.whispirClient.getResources();
		if (arrayLen(Resources) gt 1){ // Delete first one, if we have more than 1 item. Deleting last item may cause issue
			writeoutput('Deleting first Resource : #Resources[1].getName()# <br>');
			result = Resources[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(Resources) eq 1)
				writeoutput('only one Resource is available. Deleting last Resource may cause issue');
			else	
				writeoutput('There is no Resources available');
		}
	</cfscript>
</cfoutput>