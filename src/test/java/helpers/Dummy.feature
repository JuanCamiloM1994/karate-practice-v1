Feature: Dummy

Scenario: Dummy scenario
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def username = dataGenerator.getRandomUsername()
    * print 'Generated username: ' + username
    
