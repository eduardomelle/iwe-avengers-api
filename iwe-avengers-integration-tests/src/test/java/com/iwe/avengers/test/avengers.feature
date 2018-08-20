Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://lxoy065tsf.execute-api.us-east-2.amazonaws.com/dev'

#Scenario: Avenger Not Found

#Given path 'avengers', 'invalid'
#When method get
#Then status 404

#Scenario: Registry a new Avenger

#Given path 'avengers'
#And request { name: 'Spider Man', secretIdentity: 'Peter' }
#When method post
#Then status 201
#And match response == { id: '#string', name: 'Spider Man', secretIdentity: 'Peter' }

#* def savedAvenger = response

# Get Avenger by id
# $ == response
#Given path 'avengers', savedAvenger.id
#When method get
#Then status 200
#And match $ == savedAvenger

#Scenario: Update Avenger By Id

#Given path 'avengers', '22420855-7b9c-44f4-9b7d-87228fe9d6a8'
#And request { name: 'Spider Man', secretIdentity: 'Peter Parker' }
#When method put
#Then status 200
#And match response == { id: '22420855-7b9c-44f4-9b7d-87228fe9d6a8', name: 'Spider Man', secretIdentity: 'Peter Parker' }

#Scenario: Delete Avenger By Id

#Given path 'avengers', '22420855-7b9c-44f4-9b7d-87228fe9d6a8'
#When method delete
#Then status 204

Scenario: Avenger Not Found

Given path 'avengers', '22420855-7b9c-44f4-9b7d-87228fe9d6a8'
When method get
Then status 404
