Feature: Managing an Account
  As a dreamer
  In order to safely access and modify my data
  I want to be able to create and manage an account
  
  Scenario: Creating a new account
    Given I am on the home page
    And I follow "Register"
    Then I should be on the new account page
    
    When I fill in "Login" with "Cucumber"
    And I fill in "Email" with "cucumber@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Register"

    Then I should be on the account page
    And I should see "Account registered!"
