@Regression
Feature: Delete Account Testing with Different User Roles

  Background: Setup URL and Tokens
    Given url baseUrl
    * def createAccount = callonce read('classpath:features/accounts/CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id
    * def operatorResult = callonce read('classpath:features/tokens/GenerateOperatorToken.feature')
    * def operatorToken = "Bearer " + operatorResult.response.token
    * def supervisorResult = callonce read('classpath:features/tokens/GenerateSupervisorToken.feature')
    * def supervisorToken = "Bearer " + supervisorResult.response.token

  @DeleteAccount
  Scenario: Attempt account deletion with different user roles
    # Step 1: Attempt to delete with operator role (should fail with 403)
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = newAccountId
    And header Authorization = operatorToken
    When method delete
    Then status 403

    # Step 2: Attempt to delete with supervisor role (should succeed with 202)
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = newAccountId
    And header Authorization = supervisorToken
    When method delete
    Then status 202
