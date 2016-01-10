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
			describe("user", function () {

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

				it("sets a user structure exactly as in passed options", function () {

			        var _userProperties = {
			        		id :1,
			             	firstName : "John",
						    lastName : "Wick",
						    userName : "John.Wick",
						    password : "AmF10gt_x",
						    timezone : "Australia/Melbourne",
						    workEmailAddress1 : "jwick@testcompany.com",
						    workMobilePhone1 : "61423456789",
						    workCountry : "Australia"
			        };

			        userWithOptions = createobject( "component", "whispirColdFusionSDK.resources.user" )
			        					.init( whispirClient, _userProperties);

					expect( userWithOptions.getId() ).toBe( _userProperties.id );
					expect( userWithOptions.getFirstName() ).toBe( _userProperties.firstName );
					expect( userWithOptions.getLastName() ).toBe( _userProperties.lastName );
					expect( userWithOptions.getUserName() ).toBe( _userProperties.userName );
					expect( userWithOptions.getPassword() ).toBe( _userProperties.password );
					expect( userWithOptions.getWorkEmailAddress1() ).toBe( _userProperties.workEmailAddress1 );
					expect( userWithOptions.getWorkMobilePhone1() ).toBe( _userProperties.workMobilePhone1 );
					expect( userWithOptions.getWorkCountry() ).toBe( _userProperties.workCountry );

					userWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to user structure -send via options", function () {
			        var _userProperties = {
			            userId: 1,
			            id: 1
			        };

			        var userWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.user" ).init( whispirClient, _userProperties);
			        
			        expect( userWithOptionsAndInvalidProperty.getID() ).toBe( _userProperties.id );
			        expect( function() {
						userWithOptionsAndInvalidProperty.getUserId();
					}).toThrow( regex="userId is undefined in users Object" );

			        userWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /user and receive `201` for valid user structure", function () {
			        
			        var _userProperties = {
			             	firstName : "John",
						    lastName : "Wick",
						    userName : "John.Wick",
						    password : "AmF10gt_x",
						    timezone : "Australia/Melbourne",
						    workEmailAddress1 : "jwick@testcompany.com",
						    workMobilePhone1 : "61423456789",
						    workCountry : "Australia"
			        };

			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/users/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var user = whispirClient.create( 'user', _userProperties );
			        user = user.save();

			        expect(user.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(user.httpResponse.headers.location).toBe(_201Response.headers.location);

			    }); 

			    it("should POST /users and receive `422` if there a mandatory property missing in user structure", function () {
			       
			       var _userProperties = {
		        		id :1,
		             	firstName : "John",
					    lastName : "Wick",
					    password : "AmF10gt_x",
					    timezone : "Australia/Melbourne",
					    workEmailAddress1 : "jwick@testcompany.com",
					    workMobilePhone1 : "61423456789",
					    workCountry : "Australia"
			        };

			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "userName is Mandatory \n",
			                "link": []
			            }
			        };
			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var user = whispirClient.create( 'user', _userProperties );
			        var user = user.save();
			        
			        expect(user.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(user.httpResponse.body).toBe(_422Response.body);

			    });

				it("should POST /users and receive `401` for valid user structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _userProperties = {
		             	firstName : "John",
					    lastName : "Wick",
					    userName : "John.Wick",
					    password : "AmF10gt_x",
					    timezone : "Australia/Melbourne",
					    workEmailAddress1 : "jwick@testcompany.com",
					    workMobilePhone1 : "61423456789",
					    workCountry : "Australia"
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

			        var user = whispirClientMock.create( 'user', _userProperties );
			        var user = user.save();
			        
			        expect(user.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(user.httpResponse.body).toBe(_401Response.body);
			        
			    });
				
				it("should throw Error when no userID is passed", function () {

		            var user = whispirClient.create( 'user' );
		        	expect( function() {
		        		user.delete();
		        	}).toThrow( regex="user id is not provided.");

		        });

		        it("should delete user data for a given user with Id and status 204", function () {

		            var _userProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var user = whispirClient.create( 'user', _userProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( user.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong userID is passed", function () {
		        	var _userProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var user = whispirClient.create( 'user', _userProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		user.delete();
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