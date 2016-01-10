/**
* Name: whispirClient.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String"    name="apiKey" 	default="";
	property type="String"    name="username"	default="";
	property type="String"    name="password"	default="";
	property type="String"    name="apiUrl"		default="https://api.whispir.com";

	/*
	 * @description Getting access by passing API key and authorization
	 * @hint Authorization Process
	 */
	public Any function init( String apiKey = "", String username = "", String password = "" ) {

		if(arguments.username eq '' OR arguments.password eq '' OR arguments.apiKey eq ''){

			//attempt to read the auth.json file
			var path = getDirectoryFromPath( getCurrentTemplatePath() ) & "auth.json";
			if (fileExists(path)){
				try {
					var authConfig = deserializeJSON( fileRead( path ) );
					arguments.username = authConfig.username;
					arguments.password = authConfig.password;
					arguments.apiKey = authConfig.apikey;
				} catch(any e) {
					WriteLog("Couldn't find / read auth.json");
				}		
			}
		}

		if(arguments.username eq '' OR arguments.password eq '' OR arguments.apiKey eq ''){
			throw "parameters not provided or auth.json could not be read. Please configure auth.json and try again.";
		}

		setApiKey(arguments.apiKey);
		setUsername(arguments.username);
		setPassword(arguments.password);
		return this;
	}

	public Any function create( required String objectName = "", struct options = structNew() ){

		if (ArrayFindNoCase(["workspace","template","distributionList","contact","scenario","callback","user","responseRule","customList","resource","message","activity"], arguments.objectName)){
			return createobject("component", "resources." & arguments.objectName ).init( this, arguments.options );
		} else {
			throw "Resource is not available";
		}
	}

	/*
	 * @description To retrieve a list of workspaces from the Whispir.io API
	 * @hint Retrieving Workspaces
	 * @options.hint Filtering & other options
	 */
	public array function getWorkSpaces( struct options = structNew() ) {

		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'workspaces', 'GET', 'workspace', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "workspaces") and arrayLen(local.result.fileContent.workspaces) neq 0) {
			for (workspace in local.result.fileContent.workspaces){

			    workspace.ID = listlast(listFirst(workspace.link[1].uri,'?'),'/');
			    arrayAppend(local.returnArray, create('workspace').init( this, workspace ));

			}
		}
		
		return local.returnArray;
	}

	/*
	 * @description To retrieve a list of templates from the Whispir.io API
	 * @hint Retrieving Templates
	 * @options.hint Filtering & other options
	 */
	public array function getTemplates( struct options = structNew() ) {
		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'templates', 'GET', 'template', arguments.options);
		
		if ( structKeyExists(local.result, "fileContent") ){
			
			var jsonKey = "";

			if (structKeyExists(local.result.fileContent, "messagetemplates") and arrayLen(local.result.fileContent.messagetemplates) neq 0) 
				jsonKey = "messagetemplates";
			else if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "templates") and arrayLen(local.result.fileContent.templates) neq 0)
				jsonKey = "templates";

			if ( jsonKey neq "" ){
				for (template in local.result.fileContent[jsonKey]){
				    template.ID = listlast(listFirst(template.link[1].uri,'?'),'/');
			   		arrayAppend(local.returnArray, create('template').init( this, template ));
				}
			}
		}
		
		return local.returnArray;
	}

	/*
	 * @description To retrieve a list of ResponseRules from the Whispir.io API
	 * @hint Retrieving ResponseRules
	 * @options.hint Filtering & other options
	 */
	public array function getResponseRules( struct options = structNew() ) {
		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'responserules', 'GET', 'responserule', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "responseRules") and arrayLen(local.result.fileContent.responseRules) neq 0) {
			for (responseRule in local.result.fileContent.responseRules){
			    responseRule.ID = listlast(listFirst(responseRule.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('responseRule').init( this, responseRule ));
			}
		}
		
		return local.returnArray;
	}

	/*
	 * @description Retrieval of such list too is bound to the workspace it belongs to. So, a distribution list belonging to a workspace cannot be accessed from another workspace
	 * @hint Retrieving DistributionList
	 * @options.hint Filtering & other options
	 */
	public array function getDistributionLists( struct options = structNew() ) {

		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'distributionlists', 'GET', 'distributionlist', arguments.options);
		
		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "distributionlists") and arrayLen(local.result.fileContent.distributionlists) neq 0) {
			for (distributionlist in local.result.fileContent.distributionlists){
			    distributionlist.ID = listlast(listFirst(distributionlist.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('distributionlist').init( this, distributionlist ));
			}
		}
		
		return local.returnArray;
	}
	
	/*
	 * @description Contacts can be retrieved quite easily with a GET request
	 * @hint Retrieving Contacts
	 * @options.hint Filtering & other options
	 */
		
	 public array function getContacts( struct options = structNew() ) {

		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'contacts', 'GET', 'contact', arguments.options);
		
		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "contacts") and arrayLen(local.result.fileContent.contacts) neq 0) {
			for (contact in local.result.fileContent.contacts){
			    contact.ID = listlast(listFirst(contact.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('contact').init( this, contact ));
			}
			    
		}
		
		return local.returnArray;
	}
	/*
	 * @description To retrieve a list of scenarios from the Whispir.io API
	 * @hint Retrieving Scenarios
	 * @options.hint Filtering & other options
	 */
	public array function getScenarios( struct options = structNew() ) {

		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'scenarios', 'GET', 'scenario', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "scenarios") and arrayLen(local.result.fileContent.scenarios) neq 0) {
			for (scenario in local.result.fileContent.scenarios){
			    scenario.ID = listlast(listFirst(scenario.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('scenario').init( this, scenario ));
			}
		}
		return local.returnArray;
	}

	/*
	 * @description To retrieve a list of Messages from the Whispir.io API
	 * @hint Retrieve a Message
	 * @options.hint Filtering & other options
	 */
	public array function getMessages( struct options = structNew() ) {
		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'messages', 'GET', 'message', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "messages") and arrayLen(local.result.fileContent.messages) neq 0) {
			for (message in local.result.fileContent.messages){
			    message.ID = listlast(listFirst(message.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('message').init( this, message ));
			}
		}
		
		return local.returnArray;
	}

	/**
	 * @description To retrieve a list of Callbacks from the Whispir.io API
	 * @hint Retrieving Callbacks
	 * @options.hint Filtering & other options
	 **/
	public array function getCallbacks( struct options = structNew() ) {
		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'callbacks', 'GET', 'api-callback', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "callbacks") and arrayLen(local.result.fileContent.callbacks) neq 0) {
			for (callback in local.result.fileContent.callbacks){
			    callback.ID = listlast(listFirst(callback.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('callback').init( this, callback ));
			}
		}
		return local.returnArray;
	}
	/**
	 * @description To retrieve a list of resource from the Whispir.io API
	 * @hint Retrieving Resources
	 * @options.hint Filtering & other options
	 **/
	public array function getResources( struct options = structNew() ) {

		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'resources', 'GET', 'resource', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "Resources") and arrayLen(local.result.fileContent.Resources) neq 0) {
			for (Resource in local.result.fileContent.Resources){
			    resource.ID = listlast(listFirst(resource.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('resource').init( this, resource ));
			}
		}
		return local.returnArray;
	}

	/*
	 * @description To retrieve a list of activities from the Whispir.io API
	 * @hint Retrieving Activities
	 * @options.hint Filtering & other options
	 */
	 
	public array function getActivity ( struct options = structNew() ) {

		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'activities', 'GET', 'activity', arguments.options);

		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "activities") and arrayLen(local.result.fileContent.activities) neq 0) {
			for (activity in local.result.fileContent.activities){
			    activity.ID = listlast(listFirst(activity.link[1].uri,'?'),'/');
			   	arrayAppend(local.returnArray, create('activity').init( this, activity ));
			}
		}

		return local.returnArray;
	}
	/*
	 * @description An array of Custom Lists will be returned from the Whispir.io API
	 * @hint Retrieving custom lists
	 * @options.hint Filtering & other options
	 */
	public array function getCustomLists( struct options = structNew() ) {
		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'customlists', 'GET', 'customlist', arguments.options);
		
		if ( structKeyExists(local.result, "fileContent") ){
			
			var jsonKey = "";

			if (structKeyExists(local.result.fileContent, "customlabels") and arrayLen(local.result.fileContent.customlabels) neq 0) 
				jsonKey = "customlabels";
			else if (structKeyExists(local.result.fileContent, "customlists") and arrayLen(local.result.fileContent.customlists) neq 0) 
				jsonKey = "customlists";

			if ( jsonKey neq "" ){
				for (customList in local.result.fileContent[jsonKey]){
				    var obj = create('CustomList').init(this);
				    customList.ID = listlast(listFirst(customList.link[1].uri,'?'),'/');
			   		arrayAppend(local.returnArray, create('customList').init( this, customList ));
				}
			}
		}
			
		return local.returnArray;
	}
	/*
	 * @description Users can be retrieved quite easily with a GET request from the Whispir.io API
	 * @hint Retrieving Users
	 * @options.hint Filtering & other options
	 */
	public array function getUsers( struct options = structNew() ) {
		local.returnArray = arrayNew(1);
		local.result = doHttpCallwithFilter( 'users', 'GET', 'user', arguments.options);
		
		if (structKeyExists(local.result, "fileContent") AND structKeyExists(local.result.fileContent, "users") and arrayLen(local.result.fileContent.users) neq 0) {
			for (user in local.result.fileContent.users){
			    user.ID = listlast(listFirst(user.link[1].uri,'?'),'/');
				if ( structkeyexists(user, "CompanyName") ) user.CompanyName = user.CompanyName	;
			   	arrayAppend(local.returnArray, create('user').init( this, user ));
			}
		}
		
		return local.returnArray;
	}
	

	/**
	* @description 
	* @options.hint Filtering & other options
	**/

	public function buildUrlAndQueryString( required string type, required struct options ){
		local.returnStruct = { retURL = "", queryString = structNew() };
		
		if(structKeyExists(arguments.options, "workspaceId")) {
			local.returnStruct.retURL = "/workspaces/#arguments.options.workspaceId#";
		}

		if(structKeyExists(arguments.options, "messageId")) {
			local.returnStruct.retURL = local.returnStruct.retURL & '/messages/{#arguments.options.messageId#}';
		}	
		local.returnStruct.retURL = local.returnStruct.retURL & '/' & arguments.type;

		if(structKeyExists(arguments.options, "id")) {
			local.returnStruct.retURL = local.returnStruct.retURL & '/#arguments.options.id#';
		}

		if(structKeyExists(arguments.options, "query")) {
			local.returnStruct.queryString = arguments.options.query;
		}

		return local.returnStruct;


	}



	/**
	 * @description Generic helper function to make http request with filters
	 * @hint Generic helper function to make http request
	 * @urlPrefix.hint URL to request
	 * @method.hint Method of HTTP Call
	 * @mime.hint MIME type 
	 * @options.hint Filtering & other options
	 **/
	public struct function doHttpCallwithFilter( required string urlPrefix, required string method, required string mime, required struct options) {

		local.urlAndQueryString = buildUrlAndQueryString( arguments.urlPrefix, arguments.options );

		local.result = doHttpCall( local.urlAndQueryString.retURL,
				arguments.method,
				arguments.mime,
				{},
				local.urlAndQueryString.queryString
			);

		if (structKeyExists(url, "debug"))
			writeDump(var = local.result, label = "I am http result called from get#arguments.urlPrefix# method");

		if(structKeyExists(arguments.options, "id") AND structKeyExists(local.result,"fileContent")  AND structKeyExists(local.result,"Statuscode") AND local.result.Statuscode neq "404 Not Found" ){	
			temp = Duplicate(local.result.fileContent);
			local.result.fileContent[arguments.urlPrefix] = arrayNew(1);
			local.result.fileContent[arguments.urlPrefix][1] = temp;
		}
		return local.result;
	}

	/**
	 * @description Generic helper function to make http request
	 * @hint Generic helper function to make http request
	 * @urlPrefix.hint URL to request
	 * @method.hint Method of HTTP Call
	 * @parameters.hint HTTP parameters
	 * @mime.hint MIME type
	 **/
	public struct function doHttpCall( required string urlPrefix, required string method, required string mime, struct parameters = structNew(), struct getParameters = structNew() ) {

		local.returnStruct = {} ;
		
		local.urlWithKey = "#getApiurl()##arguments.urlPrefix#?apikey=#getApiKey()#";

		if ( ! structisempty(arguments.getParameters) ) {
			for (key in arguments.getParameters){
				local.urlWithKey = local.urlWithKey & "&#key#=#arguments.getParameters[key]#";
			}
		}
		
		if (structKeyExists(url, "debug"))
			writeDump(var = local.urlWithKey, label = "URL inside the doHTTPCall method");

		local.httpService = new Http( 	url 	= local.urlWithKey, 
										method 	= arguments.method,
										username = getUsername(),
    									password = getPassword()
									);
		httpService.addParam(type="header", name="accept", value="application/vnd.whispir.#arguments.mime#-v1+json");
		httpService.addParam(type="header", name="Content-Type", value="application/vnd.whispir.#arguments.mime#-v1+json");
		httpService.addParam(type="header", name="X-Originating-SDK", value="ColdFusion-v.1.0.0");

		if (arguments.method is 'POST' OR arguments.method is 'PUT')	{
			httpService.addParam(type="body", value="#serializeJSON(arguments.parameters)#");
		}
		local.temp = httpService.send().getprefix();
		local.returnStruct = Duplicate(local.temp);

		if(IsJSON(local.returnStruct.Filecontent))
			local.returnStruct.fileContent = deserializeJSON(local.returnStruct.Filecontent);
			

		if(NOT IsJSON(local.returnStruct.Filecontent) AND structKeyExists(url, "debug")){
		 	writeoutput("<h1>I am coming to else, please note down</h1>");
		 	writeDump(local.returnStruct.Filecontent);
		 	writeDump(arguments);writeDump(local.returnStruct);
		 	//abort;
		 }

		 return local.returnStruct;
	} 
}

