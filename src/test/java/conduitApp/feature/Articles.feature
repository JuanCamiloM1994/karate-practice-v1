Feature: Articles

  Background:
    Given url 'https://conduit-api.bondaracademy.com/api'


  Scenario: Create a new article
    Given path 'users/login'
    And request { "user": { "email": "testing123987@test.com", "password": "Hola123123" } }
    When method post
    Then status 200
    * def token = response.user.token

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Article title", "description": "Article description", "body": "Article body content" } }
    When method post
    Then status 201
    And match response.article.title == 'Article title'