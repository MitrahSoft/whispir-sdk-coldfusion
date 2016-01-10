<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		// Create
		contact = Application.whispirClient.create('contact');
		contact.setFirstName("John 1");
		contact.setLastName("Wick");
		contact.setStatus("A");
		contact.setWorkEmailAddress1("jsmith@testcompany.com");
		contact.setWorkMobilePhone1("61423456789");
		contact.setWorkCountry("Australia");
		contact.setTimezone("Australia/Melbourne");
		contact = contact.save();
		
		if( len(contact.getID()) eq 16) {
			
			// Create result 
			writeOutput("<h1>New contact</h1>");
			writeDump(var = contact, label = "New contact");

			// Update
			contact.setFirstName("John");
			contact = contact.save(); 
			writeOutput("<h1>Contact first name updated</h1>");
			writeDump(var = contact, label = "Contact first name updated");
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>