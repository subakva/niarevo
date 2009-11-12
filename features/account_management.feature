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

  Scenario: Logging into an existing account
    Given I have created an account for "cucumber"
    And I am on the home page
    And I follow "Log In"
    Then I should be on the login page

    When I fill in "Login" with "cucumber"
    And I fill in "Password" with "password"
    And I press "Login"

    Then I should be on the account page
    And I should see "Login successful!"

  Scenario: Logging out
    Given I am logged in as "cucumber"
    When I follow "Logout"
    
    Then I should be on the login page
    And I should see "Logout successful!"
