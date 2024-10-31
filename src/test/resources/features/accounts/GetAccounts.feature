@Regression
Feature: Testing Get Accounts API

  Background:
    * def result = callonce read('classpath:features/tokens/GenerateSupervisorToken.feature')
    * def token = result.response.token

  @GetAccounts_1
  Scenario: Validate unauthorized /api/accounts/get-all-accounts request
    Given url baseUrl
    Given path "/api/accounts/get-all-accounts"
    When method get
    Then status 401

  @GetAccounts_2
  Scenario: Validate authorized /api/accounts/get-all-accounts request
    Given url baseUrl
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And match response != null
