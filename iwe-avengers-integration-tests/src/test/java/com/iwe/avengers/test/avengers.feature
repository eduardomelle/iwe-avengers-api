Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://lxoy065tsf.execute-api.us-east-2.amazonaws.com/dev'

Scenario: Avenger Not Found

Given path 'avengers', 'invalid'
When method get
Then status 404

Scenario: Registry a new Avenger

Given path 'avengers'
And request { name: 'Captain America', secretIdentity: 'Steve Rogers' }
When method post
Then status 201
And match response == { id: '#string', name: 'Captain America', secretIdentity: 'Steve Rogers' }

* def savedAvenger = response

# Get Avenger by id
# $ == response
Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match $ == savedAvenger

Scenario: Delete Avenger By Id

Given path 'avengers', 'asas-sdsad-sdsa-asds'
When method delete
Then status 204

Scenario: Update Avenger By Id - Iron Man
Given path 'avengers', 'asas-sdsad-sdsa-asds'
And request { name: 'Iron Man 2', secretIdentity: 'Tony Stark 2' }
When method put
Then status 200

Scenario: Get Avenger by Id - Iron Man

Given path 'avengers', 'asas-sdsad-sdsa-asds'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man 2', secretIdentity: 'Tony Stark 2'}
