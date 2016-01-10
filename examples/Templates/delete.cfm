<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		Template = Application.WhispirClient.getTemplates();
		if (arrayLen(Template) gt 1){ // Delete first one, if we have more than 1 item. Deleting last item may cause issue
			writeoutput('Deleting first Template : #Template[1].getmessageTemplateName()# <br>');
			result = Template[1].delete();
			writeoutput(result);
		} else {
			if(arrayLen(Template) eq 1)
				writeoutput('only one Template is available. Deleting last Template may cause issue');
			else	
				writeoutput('There is no Template available');
		}
	</cfscript>
</cfoutput>

