Feature: Work with Db

Background: connect to db
  * def DbHandler = Java.type('helpers.DbHandler')

Scenario: Seed database with a new job
    * eval DbHandler.addNewJobWithName('Qa2')

Scenario: Get level for job 
    * def level = DbHandler.getMinAndMaxLevelsForJob('Qa2')
    * print level.minLvl
    * print level.maxLvl
    And match level.minLvl == '80'
    And match level.maxLvl == '120'
