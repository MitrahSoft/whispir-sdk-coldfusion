<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		callbackArray = Application.WhispirClient.getCallbacks();
		
		if (arrayLen(callbackArray) gt 0){
			writeoutput('Deleting first Callback : #callbackArray[1].getName()# <br>');
			result = callbackArray[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(callbackArray) eq 1)
				writeoutput('only one callback is available. Deleting last callback may cause issue');
			else	
				writeoutput('There is no contacts available');
		}
	</cfscript>
</cfoutput>
