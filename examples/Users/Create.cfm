<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		randomNumber = randRange(100,999);
		randomMobileNumber = randRange(100000000,999999999);
		// Create
		user = Application.whispirClient.create('user');
		user.setFirstName("John");
		user.setLastName("Wick");
		user.setUserName("John_#randomNumber#");
		user.setPassword("AmF10gt_x");
		user.setStatus("A");
		user.setTimezone("Australia/Melbourne");
		user.setWorkEmailAddress1("a_#randomNumber#jwick_#randomNumber#@testcompany#randomNumber#.com");
		user.setWorkEmailAddress2("b_#randomNumber#jwick_#randomNumber#@testcompany#randomNumber#.com");
		user.setpersonalEmailAddress1("c_#randomNumber#jwick_#randomNumber#@testcompany#randomNumber#.com");
		user.setpersonalEmailAddress2("d_#randomNumber#jwick_#randomNumber#@testcompany#randomNumber#.com");
		user.setWorkMobilePhone1("61#randomMobileNumber#");
		user.setWorkCountry("Australia");
		user = user.save(); 
		
		writeOutput("<h1>New user</h1>");
		writeDump(var = user, label = "New user");

		// Update
		if( len(user.getID()) eq 16) {
			user.setFirstName("John G");
			user = user.save(); 
			writeOutput("<h1>User first name updated</h1>");
			writeDump(var = user, label = "User first name updated");
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>