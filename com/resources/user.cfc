/**
* Name: user.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="ID";
	property type="String" name="userName";
	property type="String" name="password";
	property type="String" name="firstName";
	property type="String" name="lastName";
	property type="String" name="timezone";
	property type="String" name="Status";
	
	property type="String" name="middleName" default="";
	property type="String" name="title" default="";
	property type="String" name="nickname" default="";
	property type="String" name="companyName" default="";

	property type="String" name="jobTitle" default="";
	property type="String" name="division" default="";
	property type="String" name="department" default="";

	// Work Place Address:
    property type="String" name="workEmailAddress1" default="";
    property type="String" name="workEmailAddress2" default="";
    property type="String" name="workAddress1" default="";
    property type="String" name="workAddress2" default="";
    property type="String" name="workSuburb" default="";
    property type="String" name="workState" default="";
    property type="String" name="workPostCode" default="";
    property type="String" name="workCountry" default="";
    property type="String" name="workPostalAddress1" default="";
    property type="String" name="workPostalAddress2" default="";
    property type="String" name="workPostalSuburb" default="";
    property type="String" name="workPostalState" default="";
    property type="String" name="workPostalPostCode" default="";
    property type="String" name="workPostalCountry" default="";

    // Work Place Phones:
    property type="String" name="workMobilePhone1" default="";
    property type="String" name="workMobilePhone2" default="";
    property type="String" name="workPhoneAreaCode1" default="";
    property type="String" name="workPhone1" default="";
    property type="String" name="workPhoneAreaCode2" default="";
    property type="String" name="workPhone2" default="";
    property type="String" name="workFaxAreaCode1" default="";
    property type="String" name="workFax1" default="";
    property type="String" name="workSetellitePhone" default="";
    property type="String" name="WorkOtherPhone" default="";

	//Personal Address:
    property type="String" name="personalEmailAddress1" default="";
    property type="String" name="personalEmailAddress2" default="";
    property type="String" name="personalAddress1" default="";
    property type="String" name="personalAddress2" default="";
    property type="String" name="personalSuburb" default="";
    property type="String" name="personalState" default="";
    property type="String" name="personalCountry" default="";
    property type="String" name="personalPostCode" default="";

	//Personal Phones:
    property type="String" name="personalPhoneAreaCode1" default="";
    property type="String" name="personalPhone1" default="";
    property type="String" name="personalPhoneAreaCode2" default="";
    property type="String" name="personalPhone2" default="";
    property type="String" name="personalFaxAreaCode1" default="";
    property type="String" name="personalFax1" default="";
    property type="String" name="otherPhoneAreaCode1" default="";
    property type="String" name="otherPhone1" default="";
    property type="String" name="otherMobile" default="";

    //Teams and Roles: Not sure about this field
    // Alias Fields

    public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['ID','userName','password','firstName','lastName','timezone','Status','middleName','title','nickname','companyName','jobTitle','division','department','workEmailAddress1','workEmailAddress2','workAddress1','workAddress2','workSuburb','workState','workPostCode','workCountry','workPostalAddress1','workPostalAddress2','workPostalSuburb','workPostalState','workPostalPostCode','workPostalCountry','workMobilePhone1','workMobilePhone2','workPhoneAreaCode1','workPhone1','workPhoneAreaCode2','workPhone2','workFaxAreaCode1','workFax1','workSetellitePhone','WorkOtherPhone','personalEmailAddress1','personalEmailAddress2','personalAddress1','personalAddress2','personalSuburb','personalState','personalCountry','personalPostCode','personalPhoneAreaCode1','personalPhone1','personalPhoneAreaCode2','personalPhone2','personalFaxAreaCode1','personalFax1','otherPhoneAreaCode1','otherPhone1','otherMobile'];

		// only add valid properties to users structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in users Object' ;
		return;
	}
	
	/*
	 * @description To create a new user, use the /users endpoint. The method is POST.
	 * @hint Creating new User
	 */
	public Any function save() {
		var params = {
					    "userName" : getUserName(),
						"password" : getPassword(),
						"firstName" : getFirstName(),
						"lastName" : getLastName(),
						"timezone" : getTimezone(),
						"Status" : getStatus(),
						"middleName" : getMiddleName(),
						"title" : getTitle(),
						"nickname" : getNickname(),
						"companyName" : getCompanyName(),
						"jobTitle" : getJobTitle(),
						"division" : getDivision(),
						"department" : getDepartment(),
						"workEmailAddress1" : getWorkEmailAddress1(),
						"workEmailAddress2" : getWorkEmailAddress2(),
						"workAddress1" : getWorkAddress1(),
						"workAddress2" : getWorkAddress2(),
						"workSuburb" : getWorkSuburb(),
						"workState" : getWorkState(),
						"workPostCode" : getWorkPostCode(),
						"workCountry" : getWorkCountry(),
						"workPostalAddress1" : getWorkPostalAddress1(),
						"workPostalAddress2" : getWorkPostalAddress2(),
						"workPostalSuburb" : getWorkPostalSuburb(),
						"workPostalState" : getWorkPostalState(),
						"workPostalPostCode" : getWorkPostalPostCode(),
						"workPostalCountry" : getWorkPostalCountry(),
						"workMobilePhone1" : getWorkMobilePhone1(),
						"workMobilePhone2" : getWorkMobilePhone2(),
						"workPhoneAreaCode1" : getWorkPhoneAreaCode1(),
						"workPhone1" : getWorkPhone1(),
						"workPhoneAreaCode2" : getWorkPhoneAreaCode2(),
						"workPhone2" : getWorkPhone2(),
						"workFaxAreaCode1" : getWorkFaxAreaCode1(),
						"workFax1" : getWorkFax1(),
						"workSetellitePhone" : getWorkSetellitePhone(),
						"WorkOtherPhone" : getWorkOtherPhone(),
						"personalEmailAddress1" : getPersonalEmailAddress1(),
						"personalEmailAddress2" : getPersonalEmailAddress2(),
						"personalAddress1" : getPersonalAddress1(),
						"personalAddress2" : getPersonalAddress2(),
						"personalSuburb" : getPersonalSuburb(),
						"personalState" : getPersonalState(),
						"personalCountry" : getPersonalCountry(),
						"personalPostCode" : getPersonalPostCode(),
						"personalPhoneAreaCode1" : getPersonalPhoneAreaCode1(),
						"personalPhone1" : getPersonalPhone1(),
						"personalPhoneAreaCode2" : getPersonalPhoneAreaCode2(),
						"personalPhone2" : getPersonalPhone2(),
						"personalFaxAreaCode1" : getPersonalFaxAreaCode1(),
						"personalFax1" : getPersonalFax1(),
						"otherPhoneAreaCode1" : getOtherPhoneAreaCode1(),
						"otherPhone1" : getOtherPhone1(),
						"otherMobile" : getOtherMobile()
					};
		if (getID() eq ''){ // Adding new user
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/users",
					"POST",
					"user",
					params
				);
			if (structKeyExists(this.httpResponse, "header")){
				setID(listlast(listfirst(this.httpResponse.header,"?"),"/"));
			}
		} else {
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/users/#getID()#",
					"PUT",
					"user",
					params
			);
		}
		
		return this;
	}
	
	/*
	 * @description Deleting an user can be performed using a DELETE request to the /users/{id} endpoint. 
	 * @hint Deleting an user
	 */
	public string function delete() {

		if (getID() eq "")
			throw "User id is not provided.";

		var result = variables.whispirClientObj.doHttpCall( "/users/#getID()#",
				"DELETE",
				"user"
			);
		
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}

	}

	

}
