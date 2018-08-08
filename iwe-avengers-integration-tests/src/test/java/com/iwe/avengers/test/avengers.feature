Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://lxoy065tsf.execute-api.us-east-2.amazonaws.com/dev'

Scenario: Get Avenger by Id

Given path 'avengers', 'sdsa-sasa-asas-sasa'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony StarK'}

Scenario: Registry a new Avenger

Given path 'avengers'
And request { name: 'Captain America', secretIdentity: 'Steve Rogers' }
When method post
Then status 201