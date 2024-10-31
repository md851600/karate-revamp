@Regression
Feature: Testing Account APIs

  Background: Setup tests
    Given url baseUrl
    * def generateTokenResult = callonce read('classpath:features/tokens/GenerateSupervisorToken.feature')
    Then print generateTokenResult
    * def validToken = "Bearer " + generateTokenResult.authToken
    Given path "/api/accounts/get-account"
    Given header Authorization = validToken

  @Account_1
  Scenario: Testing /api/accounts/get-account with valid accountId
    * def accountId = 9479
    Given param primaryPersonId = accountId
    When method get
    Then status 200
    Then assert response.primaryPerson.id == accountId

  @Account_2
  Scenario: Testing /api/accounts/get-account with non-existing accountId
    * def accountId = 55231
    Given param primaryPersonId = accountId
    When method get
#    Optional step just in case if you would like to print the response
#    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id " + accountId + " not found"
