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
			describe("Contact", function () {

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
				it("sets an empty contact structure when no options is sent", function () {
					contact = createobject( "component", "whispirColdFusionSDK.resources.contact" ).init(whispirClient);
					expect( serializeJSON(contact) ).toBe('{"businessUnit":"","workPhone1":"","workPhone2":"","workSetellitePhone":"","workCountry":"","workPostCode":"","personalFaxAreaCode1":"","personalPhone1":"","personalPhone2":"","personalEmailAddress1":"","personalPhoneAreaCode1":"","personalPhoneAreaCode2":"","workPhoneAreaCode1":"","personalEmailAddress2":"","workPhoneAreaCode2":"","personalSuburb":"","otherPhone1":"","workPostalPostCode":"","workFax1":"","workEmailAddress2":"","workEmailAddress1":"","workMobilePhone2":"","workMobilePhone1":"","department":"","workFaxAreaCode1":"","workAddress2":"","workAddress1":"","workPostalSuburb":"","workPostalAddress1":"","personalState":"","personalFax1":"","companyName":"","workSuburb":"","workPostalAddress2":"","WorkOtherPhone":"","otherPhoneAreaCode1":"","personalCountry":"","workPostalCountry":"","personalAddress1":"","personalAddress2":"","division":"","jobTitle":"","otherMobile":"","workState":"","personalPostCode":"","workPostalState":"","title":""}');
				}, 'Method/init');

				it("sets a contact structure exactly as in passed options", function () {

			        var _contactProperties = {
			            id: 1,
			            firstName: 'Sample firstName',
			            lastName: 'Sample lastName',
			            status: 'A',
			            timezone: 'Australia/Melbourne'
			        };

			        contactWithOptions = createobject( "component", "whispirColdFusionSDK.resources.contact" )
			        					.init( whispirClient, _contactProperties);

					expect( contactWithOptions.getId() ).toBe( _contactProperties.id );
					expect( contactWithOptions.getFirstName() ).toBe( _contactProperties.firstName );
					expect( contactWithOptions.getLastName() ).toBe( _contactProperties.lastName );
					expect( contactWithOptions.getStatus() ).toBe( _contactProperties.status );
					expect( contactWithOptions.getTimezone() ).toBe( _contactProperties.timezone );

					contactWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to contact structure -send via options", function () {
			        var _contactProperties = {
			            Name: 'Sample',
			            id: 1
			        };

			        var contactWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.contact" ).init( whispirClient, _contactProperties);

			        expect( contactWithOptionsAndInvalidProperty.getID() ).toBe( _contactProperties.id );
			        expect( function() {
						contactWithOptionsAndInvalidProperty.getName();
					}).toThrow( regex="Name is undefined in contact Object" );

			        contactWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /contact and receive `201` for valid contact structure", function () {
			        var _contactProperties = {
			            id: 1,
			            firstName: 'Sample firstName',
			            lastName: 'Sample lastName',
			            status: 'A',
			            timezone: 'Australia/Melbourne'
			        };
			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/contacts/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var contact = whispirClient.create( 'contact', _contactProperties );
			        var contact = contact.save();
			        expect(contact.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(contact.httpResponse.headers.location).toBe(_201Response.headers.location);

			    });   
    
				it("should POST /contacts and receive `422` if there a mandatory property missing in contact structure", function () {
			        var _contactProperties = {
			            id: 1,
			            lastName: 'Sample lastName',
			            status: 'A',
			            timezone: 'Australia/Melbourne'
			        };
			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "firstName is Mandatory \n",
			                "link": []
			            }
			        };

			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var contact = whispirClient.create( 'contact', _contactProperties );
			        var contact = contact.save();
			        
			        expect(contact.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(contact.httpResponse.body).toBe(_422Response.body);

			    });

				
				it("should POST /contacts and receive `401` for valid contact structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _contactProperties = {
			            id: 1,
			            firstName: 'Sample firstName',
			            lastName: 'Sample lastName',
			            status: 'A',
			            timezone: 'Australia/Melbourne'
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

			        var contact = whispirClientMock.create( 'contact', _contactProperties );
			        var contact = contact.save();
			        
			        expect(contact.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(contact.httpResponse.body).toBe(_401Response.body);

				});

				it("should throw Error when no contactID is passed", function () {

		            var contact = whispirClient.create( 'contact' );
		        	expect( function() {
		        		contact.delete();
		        	}).toThrow( regex="contact id is not provided.");

		        });

		        it("should delete contact data for a given contact with Id and status 204", function () {

		            var _contactProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var contact = whispirClient.create( 'contact', _contactProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( contact.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong contactID is passed", function () {
		        	var _contactProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var contact = whispirClient.create( 'contact', _contactProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		contact.delete();
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