<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		responseRule = Application.whispirClient.create('responseRule');
		responseRule.setName("Response Rule");
		responseRule.setDescription("");
		responseRule.setResponseTemplatePatterns('{
		    "responseTemplatePattern" : [ {
		      "name" : "Yes Rule",
		      "textPrompt" : "YES",
		      "voicePrompt" : "1",
		      "spokenVoicePrompt" : "to select YES",
		      "pattern" : "startswith",
		      "colour" : "##00947d"
		    } ]
		}');
		responseRule = responseRule.save(); // Create
		
		if( len(responseRule.getID()) eq 16) {
			responseRule.setName("SMS Response");
			responseRule = responseRule.save(); // Update
			writeDump(responseRule);
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>