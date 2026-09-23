Feature: Create Token

  Scenario: Successfully create a token
    Given url apiURL
    Given path 'users/login'
    And request { "user": { "email": "#(userEmail)", "password": "#(userPassword)" } }
    When method post
    Then status 200
    * def authToken = response.user.token
