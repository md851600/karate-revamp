@Regression
Feature: Generate Token for Supervisor User

  Background:
    # Load the JSON file
    * def data = read('classpath:data/credentials.json')

    # Access values from the JSON file
    * def baseUrl = baseUrl
    * def supervisorUsername = data.supervisorCredentials.username
    * def supervisorPassword = data.supervisorCredentials.password


  Scenario: Generate valid token for supervisor
    Given url baseUrl
    And path '/api/token'
    And request
      """
      {
        "username": "#(supervisorUsername)",
        "password": "#(supervisorPassword)"
      }
      """
    When method post
    Then status 200
    And match response != null
    And def authToken = response.token
