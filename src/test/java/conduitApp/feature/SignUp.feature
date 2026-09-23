Feature: Sign up new user

Background: Preconditions
    Given url apiURL

@NewUser
Scenario: New user sign up
    Given def userData = { "email": "newuserTesting567@test.com", "username": "newusertesting567" }
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
