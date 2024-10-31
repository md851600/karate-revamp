@Regression
Feature: End-to-End Testing: Create to Delete an Account

  Background: Setup Token and URL
    Given url baseUrl
    * def supervisorToken = callonce read('classpath:features/tokens/GenerateSupervisorToken.feature')
    * def token = "Bearer " + supervisorToken.response.token

  @End2EndAccount
  Scenario: Successfully create, retrieve, and delete an account
    # Step 1: Create Account
    * def createAccount = callonce read('classpath:features/accounts/CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id

    # Step 2: Retrieve the created account and verify details
    Given path "/api/accounts/get-account"
    And header Authorization = token
    And param primaryPersonId = newAccountId
    When method get
    Then status 200
    And assert response.primaryPerson.id == newAccountId
    And assert response.primaryPerson.email == createAccount.response.email
    And assert response.primaryPerson.gender == createAccount.response.gender
    And assert response.primaryPerson.firstName == createAccount.response.firstName

    # Step 3: Delete the created account
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = newAccountId
    And header Authorization = token
    When method delete
    Then status 202

    # Step 4: Verify the account no longer exists by attempting another delete
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = newAccountId
    And header Authorization = token
    When method delete
    Then status 404
    And assert response.errorMessage == "Account with id " + newAccountId + " not exist"
