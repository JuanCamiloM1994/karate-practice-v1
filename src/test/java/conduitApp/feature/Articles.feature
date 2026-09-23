
Feature: Articles

  Background: Define URL
    Given url 'https://conduit-api.bondaracademy.com/api/'
    #  Given path 'users/login'
    # And request { "user": { "email": "testing123987@test.com", "password": "Hola123123" } }
    # When method post
    # Then status 200
    # * def token = response.user.token
    #* def tokenResponse = call read('classpath:helpers/CreateToken.feature')
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') { "email": "testing123987@test.com", "password": "Hola123123" }
    * def token = tokenResponse.authToken


  Scenario: Create a new article

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Article title", "description": "Article description", "body": "Article body content" } }
    When method post
    Then status 201
    And match response.article.title == 'Article title'

    @DeleteArticle
  Scenario: Create and delete an article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request { "article": { "tagList": [], "title": "Delete Article", "description": "Article description", "body": "Article body content" } }
    When method post
    Then status 201
    * def articleId = response.article.slug
    
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    Given header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title == 'Delete Article'

    Given header Authorization = 'Token ' + token
    Given path 'articles/', articleId
    When method Delete
    Then status 204

    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    Given header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title != 'Delete Article'
    