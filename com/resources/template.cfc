/**
* Name: template.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="ID";
	property type="String" name="messageTemplateName";
	property type="String" name="messageTemplateDescription";
	property type="String" name="subject";
	property type="String" name="body";
	property type="String" name="email";
	property type="String" name="voice";
	property type="String" name="web";
	
	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'messageTemplateName', 'messageTemplateDescription', 'subject', 'body' ,'email', 'voice', 'web'];

		// only add valid properties to Template structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in Template Object' ;
		return;
	}
	
	/*
	 * @description To create a new message template, use the /templates endpoint.
	 * @hint Creating Templates
	 */
	public Any function save() {
		var params = { 
				   "messageTemplateName": getMessageTemplateName(), 
				   "messageTemplateDescription": getMessageTemplateDescription(),
				   "subject" : getSubject(),
				   "body" : getBody(),
				   "email" : deserializeJSON(getEmail()),
				   "voice" : deserializeJSON(getVoice()),
				   "web" : deserializeJSON(getWeb())
				};
				
		if (getID() eq ''){ // Adding new Template
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/templates",
				"POST",
				"template",
				params
			);
			if (structKeyExists(this.httpResponse, "header")){
				setID(listlast(listfirst(this.httpResponse.header,"?"),"/"));
			}
		} else {
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/templates/#getID()#",
				"PUT",
				"template",
				params
			);
		}
		
		return this;
	}
	/*
	 * @description Deleting a template is done via the DELETE method.
	 * @hint Deleting Template
	 */
	public string function delete() {

		if (getID() eq "")
			throw "Template id is not provided.";
			
		var result = variables.whispirClientObj.doHttpCall( "/templates/#getID()#",
			"DELETE",
			"template"
		);
		
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}
	}

	

}
