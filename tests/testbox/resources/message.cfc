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
    	whispirClientMock = getMockBox().createMock("whispirColdFusionSDK.whispirClient");
    	whispirClient = createobject( "component", "whispirColdFusionSDK.whispirClient");
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
			describe("message", function () {

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
				it("sets an empty message structure when no options is sent", function () {
					message = createobject( "component", "whispirColdFusionSDK.resources.message" ).init(whispirClientMock);
					expect( serializeJSON(message) ).toBe('{}');
				}, 'Method/init');

				it("sets a message structure exactly as in passed options", function () {

			        var _messageProperties = {
			            id: 1,
			            to: '+1000000000',
			            subject: 'sample message',
			            body: 'Test message',
			            type: 'sms',
			            callbackName: 'whispirCallback'
			        };

			        messageWithOptions = createobject( "component", "whispirColdFusionSDK.resources.message" )
			        					.init( whispirClientMock, _messageProperties);

					expect( messageWithOptions.getId() ).toBe( _messageProperties.id );
					expect( messageWithOptions.getTo() ).toBe( _messageProperties.to );
					expect( messageWithOptions.getSubject() ).toBe( _messageProperties.subject );
					expect( messageWithOptions.getBody() ).toBe( _messageProperties.body );
					expect( messageWithOptions.getType() ).toBe( _messageProperties.type );
					expect( messageWithOptions.getCallbackName() ).toBe( _messageProperties.callbackName );

					messageWithOptions = "";

			    }, 'Method/init');

			    it("should not add an `invalid property` to message structure -send via options", function () {
			        var _messageProperties = {
			            message_Id: 1,
			            id: 1
			        };

			        var messageWithOptionsAndInvalidProperty = createobject( "component", "whispirColdFusionSDK.resources.message" ).init( whispirClientMock, _messageProperties);

			        expect( messageWithOptionsAndInvalidProperty.getID() ).toBe( _messageProperties.id );
			        expect( function() {
						messageWithOptionsAndInvalidProperty.getmessage_Id();
					}).toThrow( regex="message_Id is undefined in message Object" );

			        messageWithOptionsAndInvalidProperty = "";
			    });

			    
		        it("should throw Error when update is called - Update is not allowed for message", function () {
		            var message = createobject( "component", "whispirColdFusionSDK.resources.message" ).init(whispirClientMock);
		            expect(function () { message.update(); }).toThrow(regex='Updating a message is not supported via the API');
		        });
		    
		    
		        it("should throw Error when delete is called - Delete is not allowed for message", function () {
		            var message = createobject( "component", "whispirColdFusionSDK.resources.message" ).init(whispirClientMock);
		            expect(function () { message.delete(); }).toThrow(regex='Deleting a message is not supported via the API');
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