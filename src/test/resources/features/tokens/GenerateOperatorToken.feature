@Regression
Feature: Generate Token for Operator User

  Background:
    # Load the JSON file
    * def data = read('classpath:data/credentials.json')

    # Access values from the JSON file
    * def baseUrl = baseUrl
    * def operatorUsername = data.operatorCredentials.username
    * def operatorPassword = data.operatorCredentials.password

  Scenario: Generate valid token for operator
    Given url baseUrl
    And path '/api/token'
    And request
      """
      {
        "username": "#(operatorUsername)",
        "password": "#(operatorPassword)"
      }
      """
    When method post
    Then status 200
    And match response != null
    And def authToken = response.token
