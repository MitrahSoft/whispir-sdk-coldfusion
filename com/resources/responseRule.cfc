/**
* Name: responseRule.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="ID";
	property type="String" name="Name";
	property type="String" name="Description";
	property type="String" name="ResponseTemplatePatterns";

	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'Name', 'Description', 'ResponseTemplatePatterns'];

		// only add valid properties to ResponseRule structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in ResponseRule Object' ;
		return;
	}
	/*
	 * @description To create a new Response Rule, you can use the /responserules endpoint to Whispir.io API
	 * @hint Creating Response Rules
	 */
	public Any function save() {

		var params = { 
				   "name": getName(), 
				   "description": getDescription(),
				   "responseTemplatePatterns" : deserializeJSOn(getResponseTemplatePatterns())
				};
		if (getID() eq ''){ // Adding new Response Rule
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/responserules",
				"POST",
				"responserule",
				params
			);
			if (structKeyExists(this.httpResponse, "header")){
				setID(listlast(listfirst(this.httpResponse.header,"?"),"/"));
			}
		} else {
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/responserules/#getID()#",
				"PUT",
				"responserule",
				params
			);
		}
		return this;
	}
	/*
	 * @description To delete a responseRule to Whispir.io API
	 * @hint Deleting Response Rules
	 */
	public string function delete() {
		if (getID() eq "")
			throw "responseRule id is not provided.";

		var result = variables.whispirClientObj.doHttpCall( "/responserules/#getID()#",
				"DELETE",
				"responserule"
			);
		
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}
	}
}
