@Regression
Feature: Create new Account with Random Email

  Background: Setup test
    # Load the account data from the JSON file
    * def accountData = read('classpath:data/accountData.json')
    * def baseUrl = baseUrl
    * def account = accountData.account

    # Generate a random email using the Java utility class
    * def dataGenerator = Java.type('utilities.GenerateEmail')
    * def email = dataGenerator.generateRandomEmail()


  @CreateAccount_2
  Scenario: Create Account using Java and random email
    Given url baseUrl
    Given path "/api/accounts/add-primary-account"
    Given request
      """
      {
        "email": "#(email)",
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
    Then assert response.email == email
