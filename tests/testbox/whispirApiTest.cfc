component extends="testbox.system.BaseSpec" {
	/**
	* 						*
	* 	LIFE CYCLE Methods	*
	* 						*
	**/ 
	// executes before all suites
    function beforeAll(){
    	// read the auth.json file || if not available set the global authorization, apiKey, apiURL values here
    	// mock the doHttpCall method here
    	whispirClient = getMockBox().createMock("whispirColdFusionSDK.whispirClient");
    }

	// executes after all suites
    function afterAll(){
    	// do something
    	whispirClient = "";
    }


	/**
	* 				*
	* 	BDD SUITES 	*
	* 				*
	**/ 
	function run ( testResults, testBox ) {

		// Test suite == Collection of test cases or Specs
		/** 
		* describe() starts a suite group of spec tests.
		* Arguments:
		* @title The title of the suite, Usually how you want to name the desired behavior
		* @body A closure that will resemble the tests to execute.
		* @labels [optional: default=''] The list or array of labels this suite group belongs to
		* @asyncAll [optional: default=false] If you want to parallelize the execution of the defined specs in this suite group.
		* @skip [optional: default=false] A flag that tells TestBox to skip this suite group from testing if true
		*/
		describe("Whispir Tests", function () {
			describe("Client", function () {

				//executes before every single test case or spec in THIS suite group
				beforeEach(function( currentSpec ) {

				});

				//executes after every single test case or spec in THIS suite group
				afterEach(function( currentSpec ) {

				});	

				// single test case or Spec
				/** 
				* it() describes a spec to test. Usually the title is prefixed with the suite name to create an expression.
				* Arguments:
				* @title a descriptive title for the spec. It should be easy to read and makes sure that the developer understands what it is actually testing
				* @spec A closure that represents the test to execute  function () { // test goes here }
				* @labels [optional: default=''] The list or array of labels this spec belongs to
				* @skip [optional: default=false] A flag that tells TestBox to skip this spec from testing if true
				*/
				/* init() */
				it('Should be created with passed in username, password, apiKey', function () {
					expect(whispirClient.getUsername()).toBe('');
					expect(whispirClient.getPassword()).toBe('');
					expect(whispirClient.getApiKey()).toBe('');
					expect(whispirClient.getApiUrl()).toBe('https://api.whispir.com');
				}, 'Method/init');

				/* Create() */
				it("Should check for invalid argument value sent to Create() method", function () {
					expect( function() {
						whispirClient.create('workSpace1');
					}).toThrow( regex="Resource is not available" );
				}, 'Method/Create');

				it("Should Create a Resource as passed in the argument to create method", function () {
						expect(whispirClient.create('workSpace')).toBeComponent();
						expect(whispirClient.create('workSpace')).toBeInstanceOf("whispirColdFusionSDK.resources.workSpace");
						expect(whispirClient.create('message')).toBeInstanceOf("whispirColdFusionSDK.resources.message");
					}, 'Method/Create');

				
				/* get WorkSpaces */
				it("Should return available WorkSpaces for method getWorkSpaces() ", function () {
					whispirClient.$("getWorkSpaces").$results([],[whispirClient.create('workSpace')]);
				
					var workSpacesArr = whispirClient.getWorkSpaces();
					expect( workSpacesArr ).toBeTypeOf( "array" );
					expect( arraylen(workSpacesArr) ).toBe( 0 );

					// Calling same function to get the second mocked result
					var workSpacesArr = whispirClient.getWorkSpaces();
					if(arraylen(workSpacesArr)){
						expect( workSpacesArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.workSpace");
					}

				}, 'Method/getWorkSpaces');

				/* get Templates */
				it("Should return available Templates for method getTemplates() ", function () {
					whispirClient.$("getTemplates").$results([],[whispirClient.create('Template')]);
				
					var templatesArr = whispirClient.getTemplates();
					expect( templatesArr ).toBeTypeOf( "array" );
					expect( arraylen(templatesArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var templatesArr = whispirClient.getTemplates();
					if(arraylen(templatesArr)){
						expect( templatesArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Template");
					}

				}, 'Method/getTemplates');

				/* get ResponseRules */
				it("Should return available ResponseRules for method getResponseRules() ", function () {
					whispirClient.$("getResponseRules").$results([],[whispirClient.create('ResponseRule')]);
				
					var ResponseRulesArr = whispirClient.getResponseRules();
					expect( ResponseRulesArr ).toBeTypeOf( "array" );
					expect( arraylen(ResponseRulesArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var ResponseRulesArr = whispirClient.getResponseRules();
					if(arraylen(ResponseRulesArr)){
						expect( ResponseRulesArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.ResponseRule");
					}

				}, 'Method/getResponseRules');

				/* get DistributionLists */
				it("Should return available DistributionLists for method getDistributionLists() ", function () {
					whispirClient.$("getDistributionLists").$results([],[whispirClient.create('DistributionList')]);
				
					var DistributionListsArr = whispirClient.getDistributionLists();
					expect( DistributionListsArr ).toBeTypeOf( "array" );
					expect( arraylen(DistributionListsArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var DistributionListsArr = whispirClient.getDistributionLists();
					if(arraylen(DistributionListsArr)){
						expect( DistributionListsArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.DistributionList");
					}

				}, 'Method/getDistributionLists');


				/* get Contacts */
				it("Should return available Contacts for method getContacts() ", function () {
					whispirClient.$("getContacts").$results([],[whispirClient.create('Contact')]);
				
					var ContactsArr = whispirClient.getContacts();
					expect( ContactsArr ).toBeTypeOf( "array" );
					expect( arraylen(ContactsArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var ContactsArr = whispirClient.getContacts();
					if(arraylen(ContactsArr)){
						expect( ContactsArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Contact");
					}

				}, 'Method/getContacts');

				/* get Scenarios */
				it("Should return available Scenarios for method getScenarios() ", function () {
					whispirClient.$("getScenarios").$results([],[whispirClient.create('Scenario')]);
				
					var ScenariosArr = whispirClient.getScenarios();
					expect( ScenariosArr ).toBeTypeOf( "array" );
					expect( arraylen(ScenariosArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var ScenariosArr = whispirClient.getScenarios();
					if(arraylen(ScenariosArr)){
						expect( ScenariosArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Scenario");
					}

				}, 'Method/getScenarios');

				/* get Messages */
				it("Should return available Messages for method getMessages() ", function () {
					whispirClient.$("getMessages").$results([],[whispirClient.create('Message')]);
				
					var MessagesArr = whispirClient.getMessages();
					expect( MessagesArr ).toBeTypeOf( "array" );
					expect( arraylen(MessagesArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var MessagesArr = whispirClient.getMessages();
					if(arraylen(MessagesArr)){
						expect( MessagesArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Message");
					}

				}, 'Method/getMessages');

				/* get Callbacks */
				it("Should return available Callbacks for method getCallbacks() ", function () {
					whispirClient.$("getCallbacks").$results([],[whispirClient.create('Callback')]);
				
					var CallbacksArr = whispirClient.getCallbacks();
					expect( CallbacksArr ).toBeTypeOf( "array" );
					expect( arraylen(CallbacksArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var CallbacksArr = whispirClient.getCallbacks();
					if(arraylen(CallbacksArr)){
						expect( CallbacksArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Callback");
					}

				}, 'Method/getCallbacks');

				/* get Resources */
				it("Should return available Resources for method getResources() ", function () {
					whispirClient.$("getResources").$results([],[whispirClient.create('Resource')]);
				
					var ResourcesArr = whispirClient.getResources();
					expect( ResourcesArr ).toBeTypeOf( "array" );
					expect( arraylen(ResourcesArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var ResourcesArr = whispirClient.getResources();
					if(arraylen(ResourcesArr)){
						expect( ResourcesArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Resource");
					}

				}, 'Method/getResources');

				/* get Activity */
				it("Should return available Activity for method getActivity() ", function () {
					whispirClient.$("getActivity").$results([],[whispirClient.create('Activity')]);
				
					var ActivityArr = whispirClient.getActivity();
					expect( ActivityArr ).toBeTypeOf( "array" );
					expect( arraylen(ActivityArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var ActivityArr = whispirClient.getActivity();
					if(arraylen(ActivityArr)){
						expect( ActivityArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.Activity");
					}

				}, 'Method/getActivity');

				/* get CustomLists */
				it("Should return available CustomLists for method getCustomLists() ", function () {
					whispirClient.$("getCustomLists").$results([],[whispirClient.create('CustomList')]);
				
					var CustomListsArr = whispirClient.getCustomLists();
					expect( CustomListsArr ).toBeTypeOf( "array" );
					expect( arraylen(CustomListsArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var CustomListsArr = whispirClient.getCustomLists();
					if(arraylen(CustomListsArr)){
						expect( CustomListsArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.CustomList");
					}

				}, 'Method/getCustomLists');

				/* get Users */
				it("Should return available Users for method getUsers() ", function () {
					whispirClient.$("getUsers").$results([],[whispirClient.create('User')]);
				
					var UsersArr = whispirClient.getUsers();
					expect( UsersArr ).toBeTypeOf( "array" );
					expect( arraylen(UsersArr) ).toBe( 0 );
					
					// Calling same function to get the second mocked result
					var UsersArr = whispirClient.getUsers();
					if(arraylen(UsersArr)){
						expect( UsersArr[1] ).toBeInstanceOf("whispirColdFusionSDK.resources.User");
					}

				}, 'Method/getUsers');


			});
		});
	}

	/**
	* 
	* 	Private Methods
	* 
	**/
	private function isTravis(){
		return ( structKeyExists( url, "isTravis" ) and url.isTravis eq 1 );
	}
}