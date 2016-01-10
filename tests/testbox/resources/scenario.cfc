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
			describe("scenario", function () {

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
				it("sets an empty scenario structure when no options is sent", function () {
					scenario = createobject( "component", "whispirColdFusionSDK.resources.scenario" ).init(whispirClient);
					expect( serializeJSON(scenario) ).toBe('{"social":"{}","allowedUsers":"EVERYONE","label":"","voice":"{}","email":"{}","allowedUserIds":"","web":"{}"}');
				}, 'Method/init');

				it("sets a scenario structure exactly as in passed options", function () {

			        var _scenarioProperties = {
			            id: 1,
			            Title: 'Sample scenario',
			            Description: 'Scenario Description',
			            To: '+1000000000',
			            Subject: 'Sample scenario',
			            Body: 'scenario body'
			        };

			        scenarioWithOptions = createobject( "component", "whispirColdFusionSDK.resources.scenario" )
			        					.init( whispirClient, _scenarioProperties);

					expect( scenarioWithOptions.getTitle() ).toBe( _scenarioProperties.title );
					expect( scenarioWithOptions.getDescription() ).toBe( _scenarioProperties.description );
					expect( scenarioWithOptions.getTo() ).toBe( _scenarioProperties.to );
					expect( scenarioWithOptions.getSubject() ).toBe( _scenarioProperties.subject );
					expect( scenarioWithOptions.getBody() ).toBe( _scenarioProperties.body );

					scenarioWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to scenario structure -send via options", function () {
			        var _scenarioProperties = {
			            scenarioId: 1,
			            id: 1
			        };

			        var scenarioWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.scenario" ).init( whispirClient, _scenarioProperties);
			        expect( scenarioWithOptionsAndInvalidProperty.getID() ).toBe( _scenarioProperties.id );
			        expect( function() {
						scenarioWithOptionsAndInvalidProperty.getscenarioId();
					}).toThrow( regex="scenarioId is undefined in scenario Object" );

			        scenarioWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /scenario and receive `201` for valid scenario structure", function () {
			        
			        var _scenarioProperties = {
			            Title: 'Sample scenario',
			            Description: 'Scenario Description',
			            To: '+1000000000',
			            Subject: 'Sample scenario',
			            Body: 'scenario body'
			        };

			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/scenarios/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var scenario = whispirClient.create( 'scenario', _scenarioProperties );
			        scenario = scenario.save();

			        expect(scenario.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(scenario.httpResponse.headers.location).toBe(_201Response.headers.location);

			    }); 

			    it("should POST /scenarios and receive `422` if there a mandatory property missing in scenario structure", function () {
			       
			        var _scenarioProperties = {
			            id: 1,
			            Title: 'Sample scenario',
			            Description: 'Scenario Description',
			            Subject: 'Sample scenario',
			            Body: 'scenario body'
			        };

			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "To is Mandatory \n",
			                "link": []
			            }
			        };
			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var scenario = whispirClient.create( 'scenario', _scenarioProperties );
			        var scenario = scenario.save();
			        
			        expect(scenario.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(scenario.httpResponse.body).toBe(_422Response.body);

			    });

				it("should POST /scenarios and receive `401` for valid scenario structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _scenarioProperties = {
			            id: 1,
			            Title: 'Sample scenario',
			            Description: 'Scenario Description',
			            To: '+1000000000',
			            Subject: 'Sample scenario',
			            Body: 'scenario body'
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

			        var scenario = whispirClientMock.create( 'scenario', _scenarioProperties );
			        var scenario = scenario.save();
			        
			        expect(scenario.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(scenario.httpResponse.body).toBe(_401Response.body);
			        
			    });

				it("should throw Error when no scenarioID is passed", function () {

		            var scenario = whispirClient.create( 'scenario' );
		        	expect( function() {
		        		scenario.delete();
		        	}).toThrow( regex="scenario id is not provided.");

		        });

		        it("should delete scenario data for a given scenario with Id and status 204", function () {

		            var _scenarioProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var scenario = whispirClient.create( 'scenario', _scenarioProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( scenario.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong scenarioID is passed", function () {
		        	var _scenarioProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var scenario = whispirClient.create( 'scenario', _scenarioProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		scenario.delete();
		        	}).toThrow( regex="The resource that you have requested does not exist.");
		        	
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