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
			describe("DistributionList", function () {

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
				it("sets an empty distributionList structure when no options is sent", function () {
					distributionList = createobject( "component", "whispirColdFusionSDK.resources.distributionList" ).init(whispirClient);
					expect( serializeJSON(distributionList) ).toBe('{}');
				}, 'Method/init');

				it("sets a distributionList structure exactly as in passed options", function () {

			        var _distributionListProperties = {
			            id: 1,
			            Name: 'Sample distributionList',
			            Description:'Sample',
			            Access: 'Open',
			            Visibility: 'Public',
			            ContactIds: '',
			            UserIds:'' ,
			            DistListIds:'' 
			        };

			        distributionListWithOptions = createobject( "component", "whispirColdFusionSDK.resources.distributionList" )
			        					.init( whispirClient, _distributionListProperties);

					expect( distributionListWithOptions.getId() ).toBe( _distributionListProperties.id );
					expect( distributionListWithOptions.getName() ).toBe( _distributionListProperties.Name );
					expect( distributionListWithOptions.getDescription() ).toBe( _distributionListProperties.Description );
					expect( distributionListWithOptions.getAccess() ).toBe( _distributionListProperties.Access );
					expect( distributionListWithOptions.getVisibility() ).toBe( _distributionListProperties.Visibility );
					expect( distributionListWithOptions.getContactIds() ).toBe( _distributionListProperties.ContactIds );
					expect( distributionListWithOptions.getUserIds() ).toBe( _distributionListProperties.UserIds );
					expect( distributionListWithOptions.getDistListIds() ).toBe( _distributionListProperties.DistListIds );

					distributionListWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to distributionList structure -send via options", function () {
			        var _distributionListProperties = {
			            distributionListId: 1,
			            id: 1
			        };

			        var distributionListWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.distributionList" ).init( whispirClient, _distributionListProperties);

			        expect( distributionListWithOptionsAndInvalidProperty.getID() ).toBe( _distributionListProperties.id );
			        expect( function() {
						distributionListWithOptionsAndInvalidProperty.getdistributionListId();
					}).toThrow( regex="distributionListId is undefined in distribution List Object" );

			        distributionListWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /distributionList and receive `201` for valid distributionList structure", function () {
			        var _distributionListProperties = {
			            id: 1,
			            Name: 'Sample distributionList',
			            Description:'Sample',
			            Access: 'Open',
			            Visibility: 'Public',
			            ContactIds: '',
			            UserIds:'' ,
			            DistListIds:'' 
			        };
			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/distributionLists/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var distributionList = whispirClient.create( 'distributionList', _distributionListProperties );
			        var distributionList = distributionList.save();
			        expect(distributionList.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(distributionList.httpResponse.headers.location).toBe(_201Response.headers.location);

			    });   
    
				it("should POST /distributionLists and receive `422` if there a mandatory property missing in distributionList structure", function () {
			        var _distributionListProperties = {
			            id: 1,
			            Description:'Sample',
			            Access: 'Open',
			            Visibility: 'Public',
			            ContactIds: '',
			            UserIds:'' ,
			            DistListIds:''
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

			        var distributionList = whispirClient.create( 'distributionList', _distributionListProperties );
			        var distributionList = distributionList.save();
			        
			        expect(distributionList.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(distributionList.httpResponse.body).toBe(_422Response.body);

			    });

				
				it("should POST /distributionLists and receive `401` for valid distributionList structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _distributionListProperties = {
			            id: 1,
			            Name: 'Sample distributionList',
			            Description:'Sample',
			            Access: 'Open',
			            Visibility: 'Public',
			            ContactIds: '',
			            UserIds:'' ,
			            DistListIds:'' 
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

			        var distributionList = whispirClientMock.create( 'distributionList', _distributionListProperties );
			        var distributionList = distributionList.save();
			        
			        expect(distributionList.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(distributionList.httpResponse.body).toBe(_401Response.body);

			        
			    });

				it("should throw Error when no distributionListID is passed", function () {

		            var distributionList = whispirClient.create( 'distributionList' );
		        	expect( function() {
		        		distributionList.delete();
		        	}).toThrow( regex="distributionList id is not provided.");

		        });

		        it("should delete distributionList data for a given distributionList with Id and status 204", function () {

		            var _distributionListProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var distributionList = whispirClient.create( 'distributionList', _distributionListProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( distributionList.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong distributionListID is passed", function () {
		        	var _distributionListProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var distributionList = whispirClient.create( 'distributionList', _distributionListProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		distributionList.delete();
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