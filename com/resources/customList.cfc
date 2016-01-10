/**
* Name: customlist.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="Id";
	property type="String" name="name";
	property type="String" name="type";
	property type="String" name="sortType";
	property type="Array" name="customlabellists";
	property type="String" name="createdDate";


	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'name', 'type', 'sortType', 'customlabellists','createdDate'];

		// only add valid properties to customLists structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in customLists Object' ;
		return;
	}
	public any function delete(){
    	throw 'Deleting a customLists is not supported via the API';
	}
	public any function update(){
		throw 'Updating a customLists is not supported via the API';
	}

	/*
	 * @description To API allows you to be able to query the GET /customlists endpoint to Whispir.io API
	 * @hint filter
	 */
	public Any function filter(STRUCT Options) {

		var result = variables.whispirClientObj.doHttpCall( "/customlists",
				"GET",
				"customlist",
				{},
				{ "name" = arguments.Options.query.name }
			);
		
		return result;
	}

}
