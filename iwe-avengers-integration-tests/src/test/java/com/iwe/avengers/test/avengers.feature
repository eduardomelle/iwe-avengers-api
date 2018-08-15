Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://lxoy065tsf.execute-api.us-east-2.amazonaws.com/dev'

Scenario: Get Avenger by Id - Iron Man

Given path 'avengers', 'asas-sdsad-sdsa-asds'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Get Avenger by Id - Hulk

Given path 'avengers', 'aaaa-aaaa-aaaa-aaaa'
When method get
Then status 200
And match response == {id: '#string', name: 'Hulk', secretIdentity: 'Bruce Banner'}

Scenario: Registry a new Avenger

Given path 'avengers'
And request { name: 'Captain America', secretIdentity: 'Steve Rogers' }
When method post
Then status 201

Scenario: Avenger Not Found

Given path 'avengers', 'invalid'
When method get
Then status 404

Scenario: Delete Avenger By Id

Given path 'avengers', 'asas-sdsad-sdsa-asds'
When method delete
Then status 204
