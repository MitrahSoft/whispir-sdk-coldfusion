/**
* Name: workspace.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="ID";
	property type="String" name="projectName";
	property type="String" name="projectNumber";
	property type="String" name="status";
	property type="String" name="billingcostcentre";

	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'projectName', 'projectNumber', 'status', 'billingcostcentre'];

		// only add valid properties to WorkSpace structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in WorkSpace Object' ;
		return;
	}
	public any function delete(){
    	throw 'Deleting a WorkSpace is not supported via the API';
	}
	public any function update(){
		throw 'Updating a WorkSpace is not supported via the API';
	}
	/*
	 * @description To save a workspace to Whispir.io API
	 * @hint Creating a new workspace
	 */
	public Any function save() {
		
		var result = variables.whispirClientObj.doHttpCall( "/workspaces",
			"POST",
			"workspace",
			{ "projectName" = getprojectName(), "status" = getstatus(), "projectNumber" = getprojectNumber(), "billingcostcentre" = getbillingcostcentre()  }
		);
		if (structKeyExists(result, "header")){
			setID(listlast(listfirst(result.header,"?"),"/"));
		}
		return result;
	}

}