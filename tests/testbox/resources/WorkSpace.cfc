component extends="testbox.system.BaseSpec" {
	/**
	* 						*
	* 	LIFE CYCLE Methods	*
	* 						*
	**/ 
	// executes before all suites
    function beforeAll(){
    	import whispirColdFusionSDK.*;
    	import whispirColdFusionSDK.resources.*;

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
		describe("Resource Tests", function () {
			describe("WorkSpace", function () {

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
				it("sets an empty workspace structure when no options is sent", function () {
					workspace = createobject( "component", "whispirColdFusionSDK.resources.workspace" ).init(whispirClient);
					expect( serializeJSON(workspace) ).toBe('{}');
				}, 'Method/init');

				it("sets a workspace structure exactly as in passed options", function () {

			        var _workspaceProperties = {
			            id: 1,
			            projectName: 'Sample WorkSpace',
			            projectNumber: 'W001',
			            status: 'A',
			            billingcostcentre: 'BC1'
			        };

			        workspaceWithOptions = createobject( "component", "whispirColdFusionSDK.resources.workspace" )
			        					.init( whispirClient, _workspaceProperties);

					expect( workspaceWithOptions.getId() ).toBe( _workspaceProperties.id );
					expect( workspaceWithOptions.getProjectName() ).toBe( _workspaceProperties.projectName );
					expect( workspaceWithOptions.getProjectNumber() ).toBe( _workspaceProperties.projectNumber );
					expect( workspaceWithOptions.getStatus() ).toBe( _workspaceProperties.status );
					expect( workspaceWithOptions.getBillingcostcentre() ).toBe( _workspaceProperties.billingcostcentre );

					workspaceWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to workspace structure -send via options", function () {
			        var _workspaceProperties = {
			            workSpaceId: 1,
			            id: 1
			        };

			        var workSpaceWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.workspace" ).init( whispirClient, _workspaceProperties);

			        expect( workSpaceWithOptionsAndInvalidProperty.getID() ).toBe( _workspaceProperties.id );
			        expect( function() {
						workSpaceWithOptionsAndInvalidProperty.getWorkSpaceId();
					}).toThrow( regex="WorkSpaceId is undefined in WorkSpace Object" );

			        workSpaceWithOptionsAndInvalidProperty = "";
			    });

			    
		        it("should throw Error when update is called - Update is not allowed for WorkSpace", function () {
		            var workspace = createobject( "component", "whispirColdFusionSDK.resources.workspace" ).init(whispirClient);
		            expect(function () { workspace.update(); }).toThrow(regex='Updating a WorkSpace is not supported via the API');
		        });
		    
		    
		        it("should throw Error when delete is called - Delete is not allowed for WorkSpace", function () {
		            var workspace = createobject( "component", "whispirColdFusionSDK.resources.workspace" ).init(whispirClient);
		            expect(function () { workspace.delete(); }).toThrow(regex='Deleting a WorkSpace is not supported via the API');
		        });


				it("should POST /workspace and receive `201` for valid workspace structure", function () {
			        var _workspaceProperties = {
			            projectName: 'Sample WorkSpace',
			            projectNumber: 'W001',
			            status: 'A',
			            billingcostcentre: 'BC1'
			        };
			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/workspaces/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var WorkSpace = whispirClient.create( 'workSpace', _workspaceProperties );
			        var result = WorkSpace.save();
			        
			        expect(result.statusCode).toBe(_201Response.statusCode);
			        expect(result.headers.location).toBe(_201Response.headers.location);

			    });   
    



	it("should POST /workspaces and receive `422` if there a mandatory property missing in workspace structure", function () {
        var _workspaceProperties = {
            id: 1,
            projectNumber: 'W001',
            status: 'A',
            billingcostcentre: 'BC1'
        };
        var _422Response = {
            statusCode: 422,
            body: {
                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
                "errorText": "projectName is Mandatory \n",
                "link": []
            }
        };

        
        // Mock the http result
        whispirClient.$("doHttpCall").$results(_422Response);

        var WorkSpace = whispirClient.create( 'workSpace', _workspaceProperties );
        var result = WorkSpace.save();
        
        expect(result.statusCode).toBe(_422Response.statusCode);
        expect(result.body).toBe(_422Response.body);

    });

	
	it("should POST /workspaces and receive `401` for valid workspace structure but invalid Auth credentials", function () {
        var _clientConfig = { username : "username",
							password : "invalidPassword",
							apikey : "apiKey"
							};

        var _workspaceProperties = {
            id: 1,
            name: 'Sample WorkSpace',
            number: 'W001',
            status: 'A',
            billingcostcentre: 'BC1'
        };
        var _401Response = {
            statusCode: 401,
            body: {
                "links": "",
                "errorSummary": "Your username and password combination was incorrect. Please check your authentication details and try again",
                "errorText": "Unauthorized",
                "errorDetail": ""
            }
        };

        var whispirClientMock = getMockBox().createMock("whispirColdFusionSDK.whispirClient").init( argumentCollection = _clientConfig );
        // Mock the http result
        whispirClientMock.$("doHttpCall").$results(_401Response);

        var WorkSpace = whispirClientMock.create( 'workSpace', _workspaceProperties );
        var result = WorkSpace.save();
        
        expect(result.statusCode).toBe(_401Response.statusCode);
        expect(result.body).toBe(_401Response.body);

        
    });




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