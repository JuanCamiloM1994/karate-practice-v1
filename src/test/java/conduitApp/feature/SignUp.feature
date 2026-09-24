Feature: Sign up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url apiURL

@NewUser
Scenario: New user sign up
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
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
