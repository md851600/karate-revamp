@Regression
Feature: Token Generation with Valid and Invalid Credentials

  Background:
    * def credentials = read('classpath:data/credentials.json')
    Given url baseUrl
    Given path '/api/token'

  @US_1
  Scenario: Valid token with valid credentials
    Given request
      """
      {
        "username": "#(credentials.supervisorCredentials.username)",
        "password": "#(credentials.supervisorCredentials.password)"
      }
      """
    When method post
    Then print response
    Then status 200
    Then assert response.username == credentials.supervisorCredentials.username

  @US_2
  Scenario Outline: Valid token with invalid credentials
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status <statusCode>
    Then assert response.errorMessage == "<error>"

    Examples:
      | username                     | password              | statusCode | error                         |
      | Supervisorx                  | tek_supervisor        | 404        | User Supervisorx not found    |
      | #(credentials.supervisorCredentials.username) | wrong password | 400        | Password not matched          |
