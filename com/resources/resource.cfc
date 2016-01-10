/**
* Name: resource.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" output="false" displayname=""  {

	property type="string" name="ID";
	property type="string" name="name";
	property type="string" name="scope";
	property type="string" name="mimeType";
	property type="string" name="DerefUri";

	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'name', 'scope', 'mimeType','DerefUri'];

		// only add valid properties to resources structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in resources Object' ;
		return;
	}

	/*
	 * @description To create a new resource we should use the /resources end point.
	 * @hint Creating a resource
	 */
	public Any function save() {
		var params = { 
					   "name": getName(), 
					   "scope": getScope(),
					   "mimeType" : getMimeType(),
					   "derefUri" : getDerefUri()
					};
		if (getID() eq ''){ // Adding new resource
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/resources",
					"POST",
					"resource",
					params
				);
			if (structKeyExists(this.httpResponse, "header")){
				setID(listlast(listfirst(this.httpResponse.header,"?"),"/"));
			}
		} else {
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/resources/#getID()#",
					"PUT",
					"resource",
					params
				);
		}
		return this;
	}
	

	/*
	 * @description To Resources can be deleted after use. These can be both public and private in scope.
	 * @hint Deleting a resource
	 */
	public string function delete() {

		if (getID() eq "")
			throw "Resource id is not provided.";

		var result = variables.whispirClientObj.doHttpCall( "/resources/#getID()#",
				"DELETE",
				"resource"
			);
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}
	}
}