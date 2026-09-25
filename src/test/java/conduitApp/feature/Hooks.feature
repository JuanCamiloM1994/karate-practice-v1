
@hooks
Feature: Hooks

Background: hooks
    * def result = callonce read('classpath:helpers/Dummy.feature')
    * def username = result.username


    #after hooks
    * configure afterFeature = function(){ karate.call('classpath:helpers/Dummy.feature') }
    * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
    * configure afterScenario = 
    """
        function(){ karate.log('after step hook') }
    """
Scenario: first scenario
    * print 'Generated username in first scenario: ' + username
    * print 'this is first scenario'

Scenario: second scenario
    * print 'Generated username in second scenario: ' + username
    * print 'this is second scenario'
