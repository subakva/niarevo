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

  Scenario: Resetting a password
    Given I have created an account for "cucumber"
    And I am on the login page

    When I follow "Forgot your password?"
    Then I should be on the password reset page
    
    When I fill in "Email" with "cucumber@example.com"
    And I press "Reset my password"

    Then I should see "Instructions to reset your password have been emailed to you. Please check your email."
    And I should receive an email

    When I open the email
    Then I should see "http://www.niarevo.com/password_resets/[\w-]*/edit" in the email body

    When I go to my password reset page
    And I fill in "Password" with "newpassword"
    And I fill in "Password Confirmation" with "newpassword"
    And I press "Update my password and log me in"

    Then I should be on the account page
    And I should see "Password successfully updated"

  Scenario: Resetting a password with a mismatched password confirmation
    Given I have created an account for "cucumber"

    When I go to my password reset page
    And I fill in "Password" with "newpassword"
    And I fill in "Password Confirmation" with "fatfatfingers"
    And I press "Update my password and log me in"
    
    Then I should see "Password doesn't match confirmation"

  Scenario: Attempting to reset a password for an account that doesn't exist
    Given I am on the password reset page

    When I fill in "Email" with "notauser@example.com"
    And I press "Reset my password"

    Then I should see "No user was found with that email address"

  Scenario: Attempting to reset a password without the perishable token
    When I go to the wrong password reset page
    Then I should be on the login page
    And I should see "We're sorry, but we could not locate your account."
