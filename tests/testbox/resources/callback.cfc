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
			describe("callback", function () {

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


				it("sets a callback structure exactly as in passed options", function () {

			        var _callbackProperties = {
			            id: 1,
			            name: 'whispirCallback',
			            URL: 'http://www.YourSite.com/callback.cfm',
			            Type: 'querystring',
			            Key: '123456789012345',
			            ContentType: 'json',
			            Email : 'venkateshraj29@gmail.com',
			            Reply : 'enabled' ,
			            Undeliverable : 'enabled'
			        };

			        callbackWithOptions = createobject( "component", "whispirColdFusionSDK.resources.callback" )
			        					.init( whispirClient, _callbackProperties);

					expect( callbackWithOptions.getId() ).toBe( _callbackProperties.id );
					expect( callbackWithOptions.getName() ).toBe( _callbackProperties.name );
					expect( callbackWithOptions.getURL() ).toBe( _callbackProperties.URL );
					expect( callbackWithOptions.getType() ).toBe( _callbackProperties.type );
					expect( callbackWithOptions.getContentType() ).toBe( _callbackProperties.contentType );
					expect( callbackWithOptions.getEmail() ).toBe( _callbackProperties.email );
					expect( callbackWithOptions.getReply() ).toBe( _callbackProperties.reply );
					expect( callbackWithOptions.getUndeliverable() ).toBe( _callbackProperties.undeliverable );

					callbackWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to callback structure -send via options", function () {
			        var _callbackProperties = {
			            callbackId: 1,
			            id: 1
			        };

			        var callbackWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.callback" ).init( whispirClient, _callbackProperties);

			        expect( callbackWithOptionsAndInvalidProperty.getID() ).toBe( _callbackProperties.id );
			        expect( function() {
						callbackWithOptionsAndInvalidProperty.getCallbackId();
					}).toThrow( regex="callbackId is undefined in Callbacks Object" );

			        callbackWithOptionsAndInvalidProperty = "";
			    });

			    
		        it("should throw Error when update is called - Update is not allowed for callback", function () {
		            var callback = createobject( "component", "whispirColdFusionSDK.resources.callback" ).init(whispirClient);
		            expect(function () { callback.update(); }).toThrow(regex='Updating a Callbacks is not supported via the API');
		        });

		        it("should POST /callback and receive `201` for valid callback structure", function () {
			        
			        var _callbackProperties = {
			            name: 'whispirCallback',
			            URL: 'http://www.YourSite.com/callback.cfm',
			            Type: 'querystring',
			            Key: '123456789012345',
			            ContentType: 'json',
			            Email : 'venkateshraj29@gmail.com',
			            Reply : 'enabled' ,
			            Undeliverable : 'enabled'
			        };

			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/callbacks/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var callback = whispirClient.create( 'callback', _callbackProperties );
			        callback = callback.save();

			        expect(callback.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(callback.httpResponse.headers.location).toBe(_201Response.headers.location);

			    }); 

			    it("should POST /callbacks and receive `422` if there a mandatory property missing in callback structure", function () {
			       
			       var _callbackProperties = {
			            id: 1,
			            name: 'whispirCallback',
			            Type: 'querystring',
			            Key: '123456789012345',
			            ContentType: 'json',
			            Email : 'venkateshraj29@gmail.com',
			            Reply : 'enabled' ,
			            Undeliverable : 'enabled'
			        };

			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "URL is Mandatory \n",
			                "link": []
			            }
			        };
			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var callback = whispirClient.create( 'callback', _callbackProperties );
			        var callback = callback.save();
			        
			        expect(callback.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(callback.httpResponse.body).toBe(_422Response.body);

			    });

				it("should POST /callbacks and receive `401` for valid callback structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _callbackProperties = {
			            id: 1,
			            name: 'whispirCallback',
			            URL: 'http://www.YourSite.com/callback.cfm',
			            Type: 'querystring',
			            Key: '123456789012345',
			            ContentType: 'json',
			            Email : 'venkateshraj29@gmail.com',
			            Reply : 'enabled' ,
			            Undeliverable : 'enabled'
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

			        var callback = whispirClientMock.create( 'callback', _callbackProperties );
			        var callback = callback.save();
			        
			        expect(callback.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(callback.httpResponse.body).toBe(_401Response.body);
			        
			    });
				
				it("should throw Error when no callbackID is passed", function () {

		            var callback = whispirClient.create( 'callback' );
		        	expect( function() {
		        		callback.delete();
		        	}).toThrow( regex="callback id is not provided.");

		        });

		        it("should delete callback data for a given callback with Id and status 204", function () {

		            var _callbackProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var callback = whispirClient.create( 'callback', _callbackProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( callback.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong callbackID is passed", function () {
		        	var _callbackProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var callback = whispirClient.create( 'callback', _callbackProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		callback.delete();
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