<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		randomNumber = randRange(100,999);
		// Create
		distributionList = Application.whispirClient.create('distributionList');
		distributionList.setName("My Distribution List #randomNumber#");
		distributionList.setDescription("Update");
		distributionList.setAccess("Open");
		distributionList.setVisibility("Public");
		distributionList.setContactIds("");
		distributionList.setUserIds("");
		distributionList.setDistListIds("");
		distributionList.save();


		if( len(distributionList.getID()) eq 16) {
			// Create result 
			writeOutput("<h1>New distributionList</h1>");
			writeDump(var = distributionList, label = "New distributionList");

			// Update
			distributionList.setName("My Distribution List #randomNumber# updated");
			distributionList = distributionList.save();
			writeOutput("<h1>Distribution List name updated</h1>");
			writeDump(var = distributionList, label = "Distribution List name updated");
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>