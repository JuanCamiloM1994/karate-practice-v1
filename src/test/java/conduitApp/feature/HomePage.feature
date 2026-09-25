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
    * def timeValidator = read('classpath:helpers/timeValidator.js')
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
    And match each response.articles == 
    """
     {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """
    
  @conditionalLogic
  Scenario: Conditional logic
    Given params { limit: 10, offset: 0 }
    And path 'articles'
    When method Get
    Then status 200
    * def favoriteCount = response.articles[0].favoritesCount
    * def article = response.articles[0]

    #* if (favoriteCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
    * def result = favoriteCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoriteCount



    Given params { limit: 10, offset: 0 }
    And path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result

  @retryCall
  Scenario: Retry call 
    * configure retry = { count: 10, interval: 5000 }

    Given params { limit: 10, offset: 0 }
    And path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

  @sleepTest
  Scenario: Sleep call 
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

    Given params { limit: 10, offset: 0 }
    And path 'articles'
    When method Get
    * eval sleep(5000)
    Then status 200

