/**
* Name: callback.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="ID";
	property type="String" name="name";
	property type="String" name="url";
	property type="String" name="type";
	property type="String" name="key";
	property type="String" name="contentType";
	property type="String" name="email";
	property type="String" name="reply";
	property type="String" name="undeliverable";
	
	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'name', 'url', 'type','key','contentType','email','reply','undeliverable'];

		// only add valid properties to Callbacks structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in Callbacks Object' ;
		return;
	}
	public any function update(){
		throw 'Updating a Callbacks is not supported via the API';
	}
	/*
	 * @description To create a new API Callback, use the /callbacks endpoint to Whispir.io API
	 * @hint Creating new Callbacks
	 */
	public Any function save() {

		this.httpResponse = variables.whispirClientObj.doHttpCall( "/callbacks",
				"POST",
				"api-callback",
				{
				  "name" : getName(),
				  "url" : getURL(),
				  "auth" : {
				    "type" : getType(),
				    "key" : getKey()
				  },
				  "contentType" : getContentType(),
				  "email" : getEmail(),
				  "callbacks" : {
				    "reply" : getReply(),
				    "undeliverable" : getUndeliverable()
				  }
				}
			);
		if (structKeyExists(this.httpResponse, "fileContent")){
			setID(this.httpResponse.fileContent.id);
		}
		return this;
	}
	
	/*
	 * @description Deleting a callback is done via the DELETE method.
	 * @hint Deleting callback
	 */
	public Any function delete() {

		if (getID() eq "")
			throw "Callback id is not provided.";

		var result = variables.whispirClientObj.doHttpCall( "/callbacks/#getID()#",
			"DELETE",
			"api-callback"
		);
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}
	}
}
