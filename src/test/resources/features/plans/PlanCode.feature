@Regression
Feature: Testing Plan Code section

  Background:
    * def baseUrl = baseUrl
    # Generate token only once for all scenarios
    * def tokenResponse = callonce read('classpath:features/tokens/GenerateSupervisorToken.feature')
    * def token = "Bearer " + tokenResponse.response.token

  @PlanCode_1
  Scenario: Testing endpoint /api/plans/get-all-plan-code
    Given url baseUrl
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = token
    When method get
    Then print response
    Then status 200

  @PlanCode_1
  Scenario: Testing endpoint /api/plans/get-all-plan-code
    Given url baseUrl
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = token
    When method get
#   optional step, just in case if you would like to see the response
#    Then print response
    Then status 200
    Then assert response[0].planExpired == false
    Then assert response[1].planExpired == false
    Then assert response[2].planExpired == false
    Then assert response[3].planExpired == false
    Then assert response[0].createdBy == "SYSTEM"
    Then assert response[1].createdBy == "SYSTEM"
    Then assert response[2].createdBy == "SYSTEM"
    Then assert response[3].createdBy == "SYSTEM"
