<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
	 	// Create
		template = Application.whispirClient.create('template');
		template.setMessageTemplateName("Sample SMS Template #randRange(100,999)#");
		template.setMessageTemplateDescription("Template to provide an example on whispir.io");
		template.setSubject("Sample SMS Template");
		template.setBody("This is the body of my test SMS message");
		template.setEmail(serializeJSON(structNew()));
		template.setVoice(serializeJSON(structNew()));
		template.setWeb(serializeJSON(structNew()));
		template = template.save();
		
		if( len(template.getID()) eq 16) {
			// Create result 
			writeOutput("<h1>New template</h1>");
			writeDump(var = template, label = "New template");
			
			// Update
			template.setMessageTemplateName("SMS Template #randRange(100,999)#");
			template = template.save(); 
			writeOutput("<h1>Template name updated</h1>");
			writeDump(var = template, label = "Template name updated");
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>