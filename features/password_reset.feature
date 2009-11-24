Feature: Managing an Account
  As a forgetful dreamer
  In order to safely access and modify my data
  I want to be able to change my password

  Scenario: Resetting a password
    Given I have created an account for "cucumber"
    And I am on the login page

    When I follow "Forgot your password?"
    Then I should be on the password reset page
    
    When I fill in "Username or Email" with "cucumber@example.com"
    And I press "Reset Password"

    Then I should see "Instructions to reset your password have been emailed to you."
    And I should receive an email

    When I open the email
    Then I should see "http://www.niarevo.com/password_resets/[\w-]*/edit" in the email body

    When I go to my password reset page
    And I fill in "Password" with "newpassword"
    And I fill in "Password Confirmation" with "newpassword"
    And I press "Update my password and log me in"

    Then I should be on the account page
    And I should see "Your password has been updated."

  Scenario: Resetting a password with a mismatched password confirmation
    Given I have created an account for "cucumber"

    When I go to my password reset page
    And I fill in "Password" with "newpassword"
    And I fill in "Password Confirmation" with "fatfatfingers"
    And I press "Update my password and log me in"
    
    Then I should see "Password doesn't match confirmation"

  Scenario: Attempting to reset a password for an account that doesn't exist
    Given I am on the password reset page

    When I fill in "Username or email" with "notauser@example.com"
    And I press "Reset Password"

    Then I should see "Sorry, we couldn't find that account. Check for typos and try again."

  Scenario: Attempting to reset a password without the perishable token
    When I go to the wrong password reset page
    Then I should be on the login page
    And I should see "Sorry, we couldn't find that account."
