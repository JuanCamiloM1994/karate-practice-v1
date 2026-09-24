Feature: Sign up new user

  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    Given url apiURL

    @NewUser
  Scenario: New user sign up
    Given def userData = { "email": #(randomEmail), "username": #(randomUsername) }
    Given path 'users'
    And request 
    """
    { 
        "user": {
            "email": #(userData.email), 
            "password": "Password123", 
            "username": #(userData.username) 
            }
    }
    """
    When method post
    Then status 201
    And match response == 
    """
        {
            "user": {
                "id": "#number",
                "email": #(userData.email),
                "username": #(userData.username),
                "bio": "##string",
                "image": "#string",
                "token": "#string"
            }
        }
    """
@WrongUser
  Scenario Outline: Validate Sign up error message
   
    Given path 'users'
    And request 
    """
    { 
        "user": {
            "email": "<email>", 
            "password": "<password>", 
            "username": "<username>" 
            }
    }
    """
    When method post
    Then status 422
    And match response == <errorResponse>   

    Examples:
      | email                | password      | username             | errorResponse                                      |
      | #(randomEmail)       | 123Karate123  | KarateUser123        | {"errors":{"username":["has already been taken"]}} |
      | KarateUser1@test.com | 123Karate123  | #(randomUsername)    | {"errors":{"email":["has already been taken"]}}    |