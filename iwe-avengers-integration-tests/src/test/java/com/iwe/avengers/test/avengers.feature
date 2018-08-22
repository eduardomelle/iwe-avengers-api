Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://lxoy065tsf.execute-api.us-east-2.amazonaws.com/dev'

* def getToken =
"""
function() {
 var TokenGenerator = Java.type('com.iwe.avengers.test.authorization.TokenGenerator');
 var sg = new TokenGenerator();
 return sg.getToken();
}
"""
* def token = call getToken

Scenario: Avenger Not Found

Given path 'avengers', 'invalid'
And header Authorization = 'Bearer ' + token
When method get
Then status 404

Scenario: Registry a new Avenger

Given path 'avengers'
And request { name: 'Hulk', secretIdentity: 'Bruce Banner' }
And header Authorization = 'Bearer ' + token
When method post
Then status 201
And match response == { id: '#string', name: 'Hulk', secretIdentity: 'Bruce Banner' }

* def savedAvenger = response

# Get Avenger by id
# $ == response
Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $ == savedAvenger

Scenario: Update Avenger By Id

Given path 'avengers'
And request { name: 'Spider Man', secretIdentity: 'Peter' }
And header Authorization = 'Bearer ' + token
When method post
Then status 201

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And request { name: 'Spider Man', secretIdentity: 'Peter Parker' }
And header Authorization = 'Bearer ' + token
When method put
Then status 200
And match $.id == savedAvenger.id
And match $.name == 'Spider Man'
And match $.secretIdentity == 'Peter Parker'

Scenario: Attempt to update a non-existent Avenger

Given path 'avengers', 'sss-ddd-fff-eee'
And request { name: 'Spider Man', secretIdentity: 'Peter Parker' }
And header Authorization = 'Bearer ' + token
When method put
Then status 404

Scenario: Delete Avenger By Id

Given path 'avengers'
And request { name: 'Spider Man', secretIdentity: 'Peter Parker' }
And header Authorization = 'Bearer ' + token
When method post
Then status 201

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 404

Scenario: Attempt to delete a non-existent Avenger

Given path 'avengers', 'sss-ddd-fff-eee'
And header Authorization = 'Bearer ' + token
When method delete
Then status 404

Scenario: Shield return Unauthorized access

Given path 'avengers', 'anyid'
When method get
Then status 401
