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
			describe("resource", function () {

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
				it("sets an empty resource structure when no options is sent", function () {
					resource = createobject( "component", "whispirColdFusionSDK.resources.resource" ).init(whispirClient);
					expect( serializeJSON(resource) ).toBe('{}');
				}, 'Method/init');

				it("sets a resource structure exactly as in passed options", function () {

					fileContent = {
					 	"contacts" : [{
					    "firstName": "John",
					    "lastName": "Wick",
					    "workEmailAddress1": "jsmith@testcompany.com",
					    "workMobilePhone1": "61423456789",
					    "workCountry": "Australia",
					    "timezone": "Australia/Melbourne"
					  }]
					};

			        var _resourceProperties = {
			            id: 1,
			            name: 'test.json',
			            scope: 'private',
			            mimeType: 'application/json',
			            DerefUri: ToBase64(serializeJSON(fileContent))
			        };

			        resourceWithOptions = createobject( "component", "whispirColdFusionSDK.resources.resource" )
			        					.init( whispirClient, _resourceProperties);

					expect( resourceWithOptions.getId() ).toBe( _resourceProperties.id );
					expect( resourceWithOptions.getName() ).toBe( _resourceProperties.name );
					expect( resourceWithOptions.getScope() ).toBe( _resourceProperties.scope );
					expect( resourceWithOptions.getMimeType() ).toBe( _resourceProperties.mimeType );
					expect( resourceWithOptions.getDerefUri() ).toBe( _resourceProperties.DerefUri );

					resourceWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to resource structure -send via options", function () {
			       var _resourceProperties = {
			       		resourceId: 1,
			       		id :1
			        };

			        var resourceWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.resource" ).init( whispirClient, _resourceProperties);
			        expect( resourceWithOptionsAndInvalidProperty.getID() ).toBe( _resourceProperties.id );
			        expect( function() {
						resourceWithOptionsAndInvalidProperty.getresourceId();
					}).toThrow( regex="resourceId is undefined in resources Object" );
 
			        resourceWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /resource and receive `201` for valid resource structure", function () {
			        
			        fileContent = {
					 	"contacts" : [{
					    "firstName": "John",
					    "lastName": "Wick",
					    "workEmailAddress1": "jsmith@testcompany.com",
					    "workMobilePhone1": "61423456789",
					    "workCountry": "Australia",
					    "timezone": "Australia/Melbourne"
					  }]
					};

			        var _resourceProperties = {
			            name: 'test.json',
			            scope: 'private',
			            mimeType: 'application/json',
			            DerefUri: ToBase64(serializeJSON(fileContent))
			        };

			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/resources/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var resource = whispirClient.create( 'resource', _resourceProperties );
			        resource = resource.save();

			        expect(resource.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(resource.httpResponse.headers.location).toBe(_201Response.headers.location);

			    }); 

			    it("should POST /resources and receive `422` if there a mandatory property missing in resource structure", function () {
			       
			       var _resourceProperties = {
			            name: 'test.json',
			            scope: 'private',
			            mimeType: 'application/json'
			        };

			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "DerefUri is Mandatory \n",
			                "link": []
			            }
			        };
			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var resource = whispirClient.create( 'resource', _resourceProperties );
			        var resource = resource.save();
			        
			        expect(resource.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(resource.httpResponse.body).toBe(_422Response.body);

			    });

				it("should POST /resources and receive `401` for valid resource structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			       fileContent = {
					 	"contacts" : [{
					    "firstName": "John",
					    "lastName": "Wick",
					    "workEmailAddress1": "jsmith@testcompany.com",
					    "workMobilePhone1": "61423456789",
					    "workCountry": "Australia",
					    "timezone": "Australia/Melbourne"
					  }]
					};

			        var _resourceProperties = {
			            name: 'test.json',
			            scope: 'private',
			            mimeType: 'application/json',
			            DerefUri: ToBase64(serializeJSON(fileContent))
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

			        var resource = whispirClientMock.create( 'resource', _resourceProperties );
			        var resource = resource.save();
			        
			        expect(resource.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(resource.httpResponse.body).toBe(_401Response.body);
			        
			    });
				
				it("should throw Error when no resourceID is passed", function () {

		            var resource = whispirClient.create( 'resource' );
		        	expect( function() {
		        		resource.delete();
		        	}).toThrow( regex="resource id is not provided.");

		        });

		        it("should delete resource data for a given resource with Id and status 204", function () {

		            var _resourceProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var resource = whispirClient.create( 'resource', _resourceProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( resource.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong resourceID is passed", function () {
		        	var _resourceProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var resource = whispirClient.create( 'resource', _resourceProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		resource.delete();
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