/**
* Name: activity.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" output="false" displayname=""  {
	property type="string" name="ID";
	property type="string" name="module";
	property type="string" name="action";
	property type="string" name="status";
	property type="string" name="workspaceName";
	property type="string" name="description";
	property type="string" name="user";
	
	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'module', 'action', 'status', 'workspaceName','description','user'];

		// only add valid properties to activity structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in activity Object' ;
		return;
	}
	public any function delete(){
    	throw 'Deleting a activity is not supported via the API';
	}
	public any function update(){
		throw 'Updating a activity is not supported via the API';
	}
	
}