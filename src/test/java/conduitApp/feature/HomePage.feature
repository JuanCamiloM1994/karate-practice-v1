    @debug
Feature: Test for the home page 

  Background:
    Given url apiURL
  Scenario: Get all tags
    #Given url 'https://conduit-api.bondaracademy.com/api'
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains 'Git'
    And match response.tags contains ['YouTube', 'Blog']
    And match response.tags !contains 'Truck'
    And match response.tags == "#array"
    And match each response.tags == "#string"
    And match response.tags contains any ['Git', 'YouTube', 'Blog']
    #And match response.tags contains only ['Git', 'YouTube', 'Blog']


  Scenario: Get 10 articles from the page
    # Given param limit = 10
    # Given param offset = 0
    Given params { limit: 10, offset: 0 }
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == "#[10]" 
    And match response.articlesCount == 10
    And match response == { "articles": "#array", "articlesCount": 10 }
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 72
    And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == "#boolean"
    And match each response..favoritesCount == "#number"
    #null or string
    And match each response..bio == "##string" 
    