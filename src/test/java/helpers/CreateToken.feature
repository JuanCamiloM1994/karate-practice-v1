Feature: Create Token

  Scenario: Successfully create a token
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    And request { "user": { "email": "#(email)", "password": "#(password)" } }
    When method post
    Then status 200
    * def authToken = response.user.token
