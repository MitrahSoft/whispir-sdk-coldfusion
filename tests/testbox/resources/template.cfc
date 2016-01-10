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
			describe("Template", function () {

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
				it("sets an empty template structure when no options is sent", function () {
					template = createobject( "component", "whispirColdFusionSDK.resources.template" ).init(whispirClient);
					expect( serializeJSON(template) ).toBe('{}');
				}, 'Method/init');

				it("sets a template structure exactly as in passed options", function () {

			        var _templateProperties = {
			            id: 1,
			            MessageTemplateName: 'Sample template',
			            Subject: 'Sample Subject',
			            MessageTemplateDescription: 'Sample Description',
			            Body: 'This is the body of my test SMS message',
			            Email: serializeJSON(structNew()),
			            Voice : serializeJSON(structNew()),
			            Web : serializeJSON(structNew())
			        };

			        templateWithOptions = createobject( "component", "whispirColdFusionSDK.resources.template" )
			        					.init( whispirClient, _templateProperties);

					expect( templateWithOptions.getId() ).toBe( _templateProperties.id );
					expect( templateWithOptions.getMessageTemplateName() ).toBe( _templateProperties.MessageTemplateName );
					expect( templateWithOptions.getSubject() ).toBe( _templateProperties.Subject );
					expect( templateWithOptions.getMessageTemplateDescription() ).toBe( _templateProperties.MessageTemplateDescription );
					expect( templateWithOptions.getBody() ).toBe( _templateProperties.Body );
					expect( templateWithOptions.getEmail() ).toBe( _templateProperties.Email );
					expect( templateWithOptions.getVoice() ).toBe( _templateProperties.Voice );
					expect( templateWithOptions.getWeb() ).toBe( _templateProperties.Web );

					templateWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to template structure -send via options", function () {
			        var _templateProperties = {
			        	id: 1,
			        	templateId: 1,
			            MessageTemplateName: 'Sample template',
			            Subject: 'Sample Subject',
			            MessageTemplateDescription: 'Sample Description'
			        };

			        var templateWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.template" ).init( whispirClient, _templateProperties);

			        expect( templateWithOptionsAndInvalidProperty.getID() ).toBe( _templateProperties.id );
			        expect( function() {
						templateWithOptionsAndInvalidProperty.gettemplateId();
					}).toThrow( regex="templateId is undefined in template Object" );

			        templateWithOptionsAndInvalidProperty = "";
			    });

			    it("should POST /template and receive `201` for valid template structure", function () {
			        var _templateProperties = {
			            id: 1,
			            MessageTemplateName: 'Sample template',
			            Subject: 'Sample Subject',
			            MessageTemplateDescription: 'Sample Description',
			            Body: 'This is the body of my test SMS message',
			            Email: serializeJSON(structNew()),
			            Voice : serializeJSON(structNew()),
			            Web : serializeJSON(structNew())
			        };
			        var _201Response = {
			            statusCode: 201,
			            headers: {
			                location:  whispirClient.getapiUrl() & '/templates/1?apikey=apiKey'
			            }
			        };

			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_201Response);

			        var template = whispirClient.create( 'template', _templateProperties );
			        var template = template.save();
			        expect(template.httpResponse.statusCode).toBe(_201Response.statusCode);
			        expect(template.httpResponse.headers.location).toBe(_201Response.headers.location);

			    });   
    
				it("should POST /templates and receive `422` if there a mandatory property missing in template structure", function () {
			        var _templateProperties = {
			            id: 1,
			            MessageTemplateName: 'Sample template',
			            Subject: 'Sample Subject',
			            MessageTemplateDescription: 'Sample Description',
			            Email: serializeJSON(structNew()),
			            Voice : serializeJSON(structNew()),
			            Web : serializeJSON(structNew())
			        };
			        var _422Response = {
			            statusCode: 422,
			            body: {
			                "errorSummary": "Your request did not contain all of the information required to perform this method. Please check your request for the required fields to be passed in and try again. Alternatively, contact your administrator or support@whispir.com for more information",
			                "errorText": "Body is Mandatory \n",
			                "link": []
			            }
			        };

			        
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_422Response);

			        var template = whispirClient.create( 'template', _templateProperties );
			        var template = template.save();
			        
			        expect(template.httpResponse.statusCode).toBe(_422Response.statusCode);
			        expect(template.httpResponse.body).toBe(_422Response.body);

			    });

				
				it("should POST /templates and receive `401` for valid template structure but invalid Auth credentials", function () {
			        var _clientConfig = { username : "username",
										password : "invalidPassword",
										apikey : "apiKey"
										};

			        var _templateProperties = {
			            id: 1,
			            MessageTemplateName: 'Sample template',
			            Subject: 'Sample Subject',
			            MessageTemplateDescription: 'Sample Description',
			            Body: 'This is the body of my test SMS message',
			            Email: serializeJSON(structNew()),
			            Voice : serializeJSON(structNew()),
			            Web : serializeJSON(structNew())
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

			        var template = whispirClientMock.create( 'template', _templateProperties );
			        var template = template.save();
			        
			        expect(template.httpResponse.statusCode).toBe(_401Response.statusCode);
			        expect(template.httpResponse.body).toBe(_401Response.body);

			        
			    });

		
				it("should throw Error when no TemplateID is passed", function () {

		            var Template = whispirClient.create( 'template' );
		        	expect( function() {
		        		Template.delete();
		        	}).toThrow( regex="Template id is not provided.");

		        });

		        it("should delete Template data for a given template with Id and status 204", function () {

		            var _templateProperties = {
		                id: 1
		            };
		            var _204Response = {
		                statusCode: 204,
		                Responseheader : { status_Code: 204 }
		            };

		            var Template = whispirClient.create( 'template', _templateProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_204Response);

		            expect( Template.delete() ).toBe("Deleted successfully");
		        });

		        it("should throw Error when wrong TemplateID is passed", function () {
		        	var _templateProperties = {
		                id: "invalidID"
		            };
		            var _404Response = {
		                statusCode: 404,
		                Responseheader : { status_Code: 404 }
		            };

		            var Template = whispirClient.create( 'template', _templateProperties );
			        // Mock the http result
			        whispirClient.$("doHttpCall").$results(_404Response);

					expect( function() {
		        		Template.delete();
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