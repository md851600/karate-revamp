@Regression
Feature: Create Account Feature

  Background:
    # Load the JSON file with account data
    * def accountData = read('classpath:data/accountData.json')

    # Access base URL and account details from the JSON file
    * def baseUrl = baseUrl
    * def account = accountData.account
    * def tokenGenerationFeature = accountData.tokenGenerationFeature

    # Generate a unique email by appending a random number
    * def randomNumber = Math.floor(Math.random() * 10000) + 1
    * def uniqueEmail = account.email.replace("XXXX", randomNumber.toString())

  @NewAccount_1
  Scenario: Create new account
    Given url baseUrl
    Given path "/api/accounts/add-primary-account"
    Given request
      """
      {
        "email": "#(uniqueEmail)",
        "firstName": "#(account.firstName)",
        "lastName": "#(account.lastName)",
        "title": "#(account.title)",
        "gender": "#(account.gender)",
        "maritalStatus": "#(account.maritalStatus)",
        "employmentStatus": "#(account.employmentStatus)",
        "dateOfBirth": "#(account.dateOfBirth)"
      }
      """
    When method post
    Then print response
    Then status 201
    Then assert response.email == uniqueEmail

    # Save created account ID
    * def createdAccountId = response.id

    # Generate token for authorization
    * def tokenGenerationResult = callonce read(tokenGenerationFeature)
    * def validToken = "Bearer " + tokenGenerationResult.response.token

    # Delete the account created above
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = createdAccountId
    Given header Authorization = validToken
    When method delete
    Then status 202
