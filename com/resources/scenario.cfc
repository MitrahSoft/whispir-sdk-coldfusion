/**
* Name: scenario.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="ID";
	property type="String" name="title";
	property type="String" name="description";
	property type="String" name="allowedUsers" default="EVERYONE";
	property type="String" name="allowedUserIds" default="";
	property type="String" name="to";
	property type="String" name="subject";
	property type="String" name="body";
	property type="String" name="label" default="";
	property type="String" name="email";
	property type="String" name="voice";
	property type="String" name="web";
	property type="String" name="social";
	

	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'title', 'description', 'allowedUsers', 'allowedUserIds', 'to', 'subject', 'body', 'label', 'email', 'voice', 'web', 'social'];

		// only add valid properties to scenario structure
		for ( key in _structureKeys ) {
			if ( structKeyExists( arguments.options, key ) ) {
				var setter = this['set'&key];
				setter( arguments.options[key] );
			}
		}
		
		if ( isNull( getEmail() ) ){
			setEmail( serializeJSON( structNew() ) );
		}
		if ( isNull( getVoice() ) ){
			setVoice( serializeJSON( structNew() ) );
		}
		if ( isNull( getWeb() ) ){
			setWeb( serializeJSON( structNew() ) );
		}
		if ( isNull( getSocial() ) ){
			setSocial( serializeJSON( structNew() ) );
		} 

		variables.whispirClientObj = arguments.whispirClientObj;

		return this;
	}

	public any function OnMissingMethod( required string MissingMethodName, struct MissingMethodArguments ){
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in scenario Object' ;
		return;
	}

	/*
	 * @description A scenario is a combination of a message and contacts. So, its structure contains section for both message as well as contact information. API currently only supports creation of scenario with SMS as communication mode.
	 * @hint Creating a new Scenario
	 */
	public Any function save() {

		var params = { 
				   	"title": getTitle(), 
				   	"description": getDescription(),
				   	"allowedUsers" : getallowedUsers(),
					"allowedUserIds" : getallowedUserIds(),
				   	"message": {
				        "to" : getTo(),
				        "subject" : getSubject(),
				        "body" : getBody(),
				        "label" : getLabel()
				    },
				    "email" : deserializeJSON(getEmail()),
				   	"voice" : deserializeJSON(getVoice()),
				   	"web" : deserializeJSON(getWeb()),
				   	"social" : deserializeJSON(getSocial())
				};
		if (getID() eq ''){ // Adding new Scenario
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/scenarios",
				"POST",
				"scenario",
				params
			);
			if (structKeyExists(this.httpResponse, "header")){
				setID(listlast(listfirst(this.httpResponse.header,"?"),"/"));
			}
		} else {
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/scenarios/#getID()#",
				"PUT",
				"scenario",
				params
			);
		}

		return this;
	}
	
	/*
	 * @description Deleting a Scenario can be done via a DELETE call to the /scenarios endpoint. The request has to be targeted at a particular Scenario with the Scenario ID in the URI.
	 * @hint Deleting Scenario
	 */
	public string function delete() {
		if (getID() eq "")
			throw "scenario id is not provided.";
			
		var result = variables.whispirClientObj.doHttpCall( "/scenarios/#getID()#",
				"DELETE",
				"scenario"
			);		
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}
	}

	

}
