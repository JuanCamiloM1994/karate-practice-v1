Feature: Add likes

Background: add likes
    Given url apiURL
Scenario: add likes
    Given path 'articles', slug, 'favorite'
    And request {}
    When method Post
    Then status 200
    * def likesCount = response.article.favoritesCount


