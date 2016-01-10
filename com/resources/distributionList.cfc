/**
* Name: distributionList.cfc
* Author: SaravanaMuthu AKA CFMitrah (http://www.MitrahSoft.com)
* Date: 24.12.2015
**/
component accessors="true" {

	property type="String" name="id";
	property type="String" name="name";
	property type="String" name="description";
	property type="String" name="access";
	property type="String" name="visibility";
	property type="String" name="contactIds";
	property type="String" name="userIds";
	property type="String" name="distListIds";
	

	public Any function init( required whispirColdFusionSDK.whispirClient whispirClientObj, struct options = structNew() ) {
		
		var _structureKeys = ['id', 'name', 'description', 'access','visibility','contactIds','userIds','distListIds'];

		// only add valid properties to distribution list structure
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
		throw  '#replacenocase(MissingMethodName,"get","")# is undefined in distribution list Object' ;
		return;
	}

	/*
	 * @description To distribution lists can be created within the Default Workspace, or within a Specific Workspace to Whispir.io API
	 * @hint Creating Distribution lists
	 */
	public Any function save() {

		var params = { 
				   "name": getName(), 
				   "description": getDescription(),
				   "access" : getAccess(),
				   "visibility" : getVisibility(),
				   "contactIds" : getContactIds(),
				   "userIds" : getUserIds(),
				   "distListIds" : getDistListIds()
				};

		if (getID() eq ''){ // Adding new distribution list
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/distributionlists",
				"POST",
				"distributionlist",
				params
			);
			if (structKeyExists(this.httpResponse, "header")){
				setID(listlast(listfirst(this.httpResponse.header,"?"),"/"));
			}
		} else {
			var this.httpResponse = variables.whispirClientObj.doHttpCall( "/distributionlists/#getID()#",
				"PUT",
				"distributionlist",
				params
			);
		} 
		
		return this;
	}

	private any function _populateLists(){
		var getMembers = variables.whispirClientObj.doHttpCall( "/distributionlists/#getID()#",
			"GET",
			"distributionlist"
		);
		var list = { contact = "", user = "", distList = ""};
		
		if(val(getMembers.fileContent.memberCount)){
			for( singleDistList in getMembers.fileContent.distlistdetails ){
				list[singleDistList.type] = listappend( list[singleDistList.type], singleDistList.id);
			}
		}

		setContactIds(list.Contact);
		setUserIds(list.User);
		setDistListIds(list.DistList);
		setName(getMembers.fileContent.name);
		setDescription(getMembers.fileContent.Description);
		setAccess(getMembers.fileContent.Access);
		setVisibility(getMembers.fileContent.Visibility);
		
		return this;
	}
	/*
	 * @description A contact can be added to the distribution list, to Whispir.io API
	 * @hint Add Member
	 */
	 public Any function addMember(STRUCT Options) {

	 	_populateLists();
		
		if(arguments.Options.type eq 'contact'){
			setContactIds(ListRemoveDuplicates(listAppend(getContactIds(), arguments.Options.listofID)));
		} else if(arguments.Options.type eq 'user'){
			setUserIds(ListRemoveDuplicates(listAppend(getUserIds(), arguments.Options.listofID)));
		} else if (arguments.Options.type eq 'distList'){
			setDistListIds(ListRemoveDuplicates(listAppend(getDistListIds, arguments.Options.listofID)));
		}

		var result = variables.whispirClientObj.doHttpCall( "/distributionlists/#getID()#",
			"PUT",
			"distributionlist",
			{ 
			   "name": getName(), 
			   "description": getDescription(),
			   "access" : getAccess(),
			   "visibility" : getVisibility(),
			   "contactIds" : getContactIds(),
			   "userIds" : getUserIds(),
			   "distListIds" : getDistListIds()
			}
		);
		return this;
	 }
	
	/*
	 * @description A contact can be removed to the distribution list, to Whispir.io API
	 * @hint Remove Member
	 */
	 public Any function removeMember(STRUCT Options) {
	 	_populateLists();

		if(arguments.Options.type eq 'contact'){
			contactId = "";
			for(getOne in arguments.Options.listOfID){
				getPostion = listFind(getContactIds(),getone);
				if(val(getPostion)){
					contactId = listDeleteAt(getContactIds(),getPostion);
				}
			}
			setContactIds(contactId);
		} else if(arguments.Options.type eq 'user'){
			userId = "";
			for(getOne in arguments.Options.listOfID){
				getPostion = listFind(getUserIds(),getone);
				if(val(getPostion)){
					userId = listDeleteAt(getUserIds(),getPostion);
				}
			}
			setUserIds(userId);
		} else if (arguments.Options.type eq 'distList'){
			distListId = "";
			for(getOne in arguments.Options.listOfID){
				getPostion = listFind(getDistListIds(),getone);
				if(val(getPostion)){
					distListId = listDeleteAt(getDistListIds(),getPostion);
				}
			}
			setDistListIds(distListId);
		}

		var result = variables.whispirClientObj.doHttpCall( "/distributionlists/#getID()#",
			"PUT",
			"distributionlist",
			{ 
			   "name": getName(), 
			   "description": getDescription(),
			   "access" : getAccess(),
			   "visibility" : getVisibility(),
			   "contactIds" : getContactIds(),
			   "userIds" : getUserIds(),
			   "distListIds" : getDistListIds()
			}
		);
		return this;
	 }
	 
	/*
	 * @description To Deleting the distribution is done via a DELETE /distributionlist/{id} endpoint, to Whispir.io API
	 * @hint delete distribution
	 */
	public String function delete() {
		if (getID() eq "")
			throw "distributionList id is not provided.";

		var result = variables.whispirClientObj.doHttpCall( "/distributionlists/#getId()#",
				"DELETE",
				"distributionlist"
			);
		if(structKeyExists(result,"Responseheader") AND (result.Responseheader.Status_Code eq "204")){
			return "Deleted successfully";
		} else {
			throw "The resource that you have requested does not exist.";
		}
	}
}
