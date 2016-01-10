<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		fileContent = {
		 	"contacts" : [{
		    "firstName": "John",
		    "lastName": "Wick",
		    "workEmailAddress1": "jsmith@testcompany.com",
		    "workMobilePhone1": "61423456789",
		    "workCountry": "Australia",
		    "timezone": "Australia/Melbourne"
		  }]
		};

		fileBase64 = ToBase64(serializeJSON(fileContent));

		resources = Application.whispirClient.create('resource');
		resources.setName("test.json");
		resources.setScope("private");
		resources.setMimeType("application/json");
		resources.setDerefUri(fileBase64);
		resources = resources.save(); // Create
		
		if( len(resources.getID()) eq 16) {
			resources.setName("test1.json");
			resources = resources.save(); // Update
			writeDump(resources);
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>