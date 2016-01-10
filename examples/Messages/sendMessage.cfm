<a href="../../"><h4>Examples index</h4></a>
<cfoutput>
	<cfscript>
		message = Application.whispirClient.create('message');
		message.setTo("+1000000000");
		message.setSubject("Message Test");
		message.setHeader("This is the introduction of the voice call");
		message.setBody("Message Test");
		message.setType("text/plain");
		message.setfooter("Email signature goes here.");
		message.setMessageType("sms");
		message.setRichMessageBody("This is the body of my Rich Message");
		message.setCallbackName("whispirCallback3");
		message = message.sendMessage();
		writeDump(message);
	</cfscript>
</cfoutput>