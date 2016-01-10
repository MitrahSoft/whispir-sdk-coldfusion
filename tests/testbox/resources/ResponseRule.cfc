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
			describe("ResponseRule", function () {

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
				it("sets an empty ResponseRule structure when no options is sent", function () {
					ResponseRule = createobject( "component", "whispirColdFusionSDK.resources.ResponseRule" ).init(whispirClient);
					expect( serializeJSON(ResponseRule) ).toBe('{}');
				}, 'Method/init');

				it("sets a ResponseRule structure exactly as in passed options", function () {

			        var _ResponseRuleProperties = {
			            id: 1,
			            Name: 'Response Rule',
			            Description: 'Description',
			            ResponseTemplatePatterns: '{
												    "responseTemplatePattern" : [ {
												      "name" : "Yes Rule",
												      "textPrompt" : "YES",
												      "voicePrompt" : "1",
												      "spokenVoicePrompt" : "to select YES",
												      "pattern" : "startswith",
												      "colour" : "##00947d"
												    } ]
												}'
			        };

			        ResponseRuleWithOptions = createobject( "component", "whispirColdFusionSDK.resources.ResponseRule" )
			        					.init( whispirClient, _ResponseRuleProperties);

					expect( ResponseRuleWithOptions.getId() ).toBe( _ResponseRuleProperties.id );
					expect( ResponseRuleWithOptions.getName() ).toBe( _ResponseRuleProperties.Name );
					expect( ResponseRuleWithOptions.getDescription() ).toBe( _ResponseRuleProperties.Description );
					expect( ResponseRuleWithOptions.getResponseTemplatePatterns() ).toBe( _ResponseRuleProperties.ResponseTemplatePatterns );
					ResponseRuleWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to responseRule structure -send via options", function () {
			        var _responseRuleProperties = {
			            responseRuleId: 1,
			            id: 1
			        };

			        var responseRuleWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.responseRule" ).init( whispirClient, _responseRuleProperties);

			        expect( responseRuleWithOptionsAndInvalidProperty.getID() ).toBe( _responseRuleProperties.id );
			        expect( function() {
						responseRuleWithOptionsAndInvalidProperty.getresponseRuleId();
					}).toThrow( regex="responseRuleId is undefined in responseRule Object" );

			        responseRuleWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /responseRule and receive `201` for valid responseRule structure", function () {
			        var _responseRuleProperties = {
			            id: 1,
			            Name: 'Response Rule',
			            Description: 'Description',
			            ResponseTemplatePatterns: '{
												    "responseTemplatePattern" : [ {
												      "name" : "Yes Rule",
												      "textPrompt" : "YES",
												      "voicePrompt" : "1",
												      "spokenVoicePrompt" : "to select YES",
												      "pattern" : "startswith",
												      "colour" : "##00947d"
												    } ]
												}'
			        };
			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/responserules/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var responseRule = whispirClient.create( 'responseRule', _responseRuleProperties );
			        var responseRule = responseRule.save();
			        expect(responseRule.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(responseRule.httpResponse.headers.location).toBe(_201Response.headers.location);

			    });   
    
				it("should POST /responseRules and receive `422` if there a mandatory property missing in responseRule structure", function () {
			        var _responseRuleProperties = {
			            id: 1,
			            Description: 'Description',
			            ResponseTemplatePatterns: '{
												    "responseTemplatePattern" : [ {
												      "name" : "Yes Rule",
												      "textPrompt" : "YES",
												      "voicePrompt" : "1",
												      "spokenVoicePrompt" : "to select YES",
												      "pattern" : "startswith",
												      "colour" : "##00947d"
												    } ]
												}'
			        };
			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "Name is Mandatory \n",
			                "link": []
			            }
			        };

			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var responseRule = whispirClient.create( 'responseRule', _responseRuleProperties );
			        var responseRule = responseRule.save();
			        
			        expect(responseRule.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(responseRule.httpResponse.body).toBe(_422Response.body);

			    });

				
				it("should POST /responseRules and receive `401` for valid responseRule structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _responseRuleProperties = {
			            id: 1,
			            Name: 'Response Rule',
			            Description: 'Description',
			            ResponseTemplatePatterns: '{
												    "responseTemplatePattern" : [ {
												      "name" : "Yes Rule",
												      "textPrompt" : "YES",
												      "voicePrompt" : "1",
												      "spokenVoicePrompt" : "to select YES",
												      "pattern" : "startswith",
												      "colour" : "##00947d"
												    } ]
												}'
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

			        var responseRule = whispirClientMock.create( 'responseRule', _responseRuleProperties );
			        var responseRule = responseRule.save();
			        
			        expect(responseRule.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(responseRule.httpResponse.body).toBe(_401Response.body);

			        
			    });


				it("should throw Error when no responseRuleID is passed", function () {

		            var responseRule = whispirClient.create( 'responseRule' );
		        	expect( function() {
		        		responseRule.delete();
		        	}).toThrow( regex="responseRule id is not provided.");

		        });

		        it("should delete responseRule data for a given responseRule with Id and status 204", function () {

		            var _responseRuleProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var responseRule = whispirClient.create( 'responseRule', _responseRuleProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( responseRule.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong responseRuleID is passed", function () {
		        	var _responseRuleProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var responseRule = whispirClient.create( 'responseRule', _responseRuleProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		responseRule.delete();
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