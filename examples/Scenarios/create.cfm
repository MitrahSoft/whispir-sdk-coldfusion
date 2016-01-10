<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		// Create
		scenario = Application.whispirClient.create('scenario');
		scenario.setTitle("Fire Evacuation Block");
		scenario.setDescription("Fire evacuation notification for A block residents");
		scenario.setTo("+1000000000");
		scenario.setSubject("Fire Evacuation");
		scenario.setBody("A fire has been detected at level 55. Please evacuate the building immediately. Please do not use the lifts.");
		scenario = scenario.save(); 
		
		if( len(scenario.getID()) eq 16) {

			// Create result
			writeOutput("<h1>New scenario</h1>");
			writeDump(var = scenario, label = "New scenario");

			// Update
			scenario.setTitle("Fire Evacuation Block A");
			scenario = scenario.save(); 
			writeOutput("<h1>Scenario title updated</h1>");
			writeDump(var = scenario, label = "Scenario title updated");
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>