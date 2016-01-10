<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		callbacks = Application.whispirClient.create('Callback');
		callbacks.setName("whispirCallback5");
		callbacks.setURL("http://www.YourSite.com/callback.cfm");
		callbacks.setType("querystring");
		callbacks.setKey("123456789012345");
		callbacks.setContentType("json");
		callbacks.setEmail("venkateshraj29@gmail.com");
		callbacks.setReply("enabled");
		callbacks.setUndeliverable("enabled");;
		getResult = callbacks.save();
		if( len(getResult.getID()) eq 16) {
			writeDump(getResult);
		} else {
			writeDump('Not Created');
		}
	</cfscript>
</cfoutput>