/**
* Name: message.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true"{

	property type="String" name="ID";
	property type="String" name="to";
	property type="String" name="subject";
	property type="String" name="body";
	property type="String" name="type";
	property type="String" name="voice";
	property type="String" name="web";
	property type="String" name="footer";
	property type="String" name="messageID";
	property type="String" name="searchKey";
	property type="String" name="searchValue";
	property type="String" name="messageType";
	property type="String" name="Header";
	property type="String" name="SocialID";
	property type="String" name="RichMessageBody";
	property type="String" name="callbackName";

	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'to', 'subject', 'body','type','voice','web','footer','messageID','searchKey','searchValue','messageType','Header','SocialID','RichMessageBody','callbackName'];

		// only add valid properties to Message structure
		for ( key in _structureKeys ) {
			if ( structKeyExists( arguments.options, key ) ) {
				var setter = this['set'&key];
				setter( arguments.options[key] );
			}
		}
	
		variables.whispirClientObj = arguments.whispirClientObj;

		return this;
	}

	public any function OnMissingMethod( required string MissingMethodName, struct MissingMethodArguments ){
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in Message Object' ;
		return;
	}
	public any function delete(){
    	throw 'Deleting a Message is not supported via the API';
	}
	public any function update(){
		throw 'Updating a Message is not supported via the API';
	}
	/*
	 * @description Whispir has the ability to send communications across 7 different channels in a single API request
	 * @hint send Message
	 */
	public Any function sendMessage() {

		savecontent variable="messageBody" { 
			if( getMessageType() eq 'email'){
	    		WriteOutput('
	    			{ "body" : "#getBody()#",
		        	  "footer" : "#getFooter()#",
		        	   "type" : "#getType()#"}');
	   		} else if (getMessageType() eq 'voice'){
	   			WriteOutput('{
		        "header" : "#getHeader()#",
		        "body" : "#getBody()#",
		        "type" : "#getType()#" }');
	   		}else if (getMessageType() eq 'web'){
		    	 WriteOutput('{
			        "body" : "#getBody()#",
			        "type" : "#getType()#"
			    }');
		    }else if (getMessageType() eq 'social'){
		    	 WriteOutput('{
			        "social" : [{
			            "id" : "#getSocialID()#",
			            "body" : "#getBody()#"
			        }]
			    }');
		    }else if (getMessageType() eq 'sms'){
		    	 WriteOutput('{
		    	 	"body" : "#getBody()#"
		    	 	}');
		    }else if (getMessageType() eq 'rich'){
		    	writeOutput('{
		    		"body" : "#getBody()#",
		    		"web" : {
		    			"type" : "#getType()#",
		    			"body" : "#getRichMessageBody()#"
		    		}
		    		}');
		    }
	 	}
	 	
	 	var parameter = {
	 						"to" : getTo(),
	 						"subject" : getSubject(),
	 						"callbackId" : getCallbackName()
	 					};
	 	
	 	if( getMessageType() neq 'sms' AND getMessageType() neq 'rich' ){
	 		structAppend(parameter, { "#getMessageType()#" :deserializeJSON(messageBody) } );
	 	} else {
	 		structAppend(parameter, deserializeJSON(messageBody) );
	 	}

		var result = variables.whispirClientObj.doHttpCall( "/messages",
				"POST",
				"message",
				parameter
			);
		if(structKeyExists(result, "header")){
			setID(listlast(listfirst(result.header,"?"),"/"));
		} else {
			setID(listlast(listfirst(result.Header,"?"),"/"));
		}
		return this;
	}
	/*
	 * @description To the user can simply make a new API request to retrieve the summaryStatus URL. 
	 * @hint Message Status
	 */
	public Any function getMessageStatus(STRUCT Options) {

		var result = variables.whispirClientObj.doHttpCall( "/messages/#getID()#/messagestatus/",
				"GET",
				"messagestatus",
				{},
				{"view" = arguments.Options.query.view}
			);
		
		return result;
	}
	/*
	 * @description To the user can simply make a new API request to retrieve the summaryStatus URL. 
	 * @hint Message Responses
	 */
	public Any function getMessageResponses(STRUCT Options) {

		var result = variables.whispirClientObj.doHttpCall( "/messages/#getID()#/messageresponses/",
				"GET",
				"messageresponse",
				{},
				{"view" = arguments.Options.query.view}
			);
		
		return result;
	}

	

}
