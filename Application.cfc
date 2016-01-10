component output="false"{

	This.name = "MitrahSoft ColdFusion Whispir SDK ";
	This.mappings["/whispirColdFusionSDK"] = getDirectoryFromPath( getCurrentTemplatePath() ) & "com";

	public any function onRequestStart() {
								
		import whispirColdFusionSDK.*;
		import whispirColdFusionSDK.resources.*;

		// If you have auth.json file, create object like this.
		Application.whispirClient = new whispirClient();
		

		// If you don't want keep your authentication details in auth.json, Please mentioned it in below authConfig structure
		/* 
		var authConfig = { username : "Your user name",
							password : "****",
							apikey : "API Key value"
							};
		Application.whispirClient = new whispirClient( argumentCollection = authConfig);
		*/
		
	}
}