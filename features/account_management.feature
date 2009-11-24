Feature: Managing an Account
  As a dreamer
  In order to safely access and modify my data
  I want to be able to create and manage an account
  
  Scenario: Creating a new account
    Given I am on the home page
    And I follow "Register"
    Then I should be on the new account page
    
    When I fill in "Username" with "Cucumber"
    And I fill in "Email" with "cucumber@example.com"
    And I fill in "Password" with "password"
    And I fill in "Confirm Password" with "password"
    And I press "Register"

    Then I should be on the login page
    And I should see "Thanks! A message has been sent to your email address with a link to activate your account."

  Scenario: Creating a new account with a mismatched password
    Given I am on the new account page
  
    When I fill in "Username" with "Cucumber"
    And I fill in "Email" with "cucumber@example.com"
    And I fill in "Password" with "password"
    And I fill in "Confirm Password" with "WRONG"
    And I press "Register"

    Then I should be on the failed new account page
    And I should see "Password doesn't match confirmation"

  Scenario: Creating a new account with missing information
    Given I am on the new account page

    When I fill in "Username" with ""
    And I fill in "Email" with ""
    And I fill in "Password" with ""
    And I fill in "Confirm Password" with ""
    And I press "Register"

    Then I should be on the failed new account page
    And I should see "Password confirmation is too short (minimum is 4 characters)"
    And I should see "Password is too short (minimum is 4 characters)"
    And I should see "Password doesn't match confirmation"
    And I should see "Username is too short (minimum is 3 characters)"
    And I should see "Username should use only letters, numbers, spaces, and .-_@ please."
    And I should see "Email is too short (minimum is 6 characters)"
    And I should see "Email should look like an email address."

  Scenario: Logging into an existing account
    Given I have created an account for "cucumber"
    And I am on the home page
    And I follow "Sign In"
    Then I should be on the login page

    When I fill in "Username" with "cucumber"
    And I fill in "Password" with "password"
    And I press "Sign In"

    Then I should be on the account page

  Scenario: Logging in with the wrong password
    Given I have created an account for "cucumber"
    And I am on the login page

    When I fill in "Username" with "cucumber"
    And I fill in "Password" with "WRONG!!"
    And I press "Sign In"

    Then I should be on the failed login page
    And I should see "Please enter a correct username and password. Note that both fields are case-sensitive."

  Scenario: Accessing the login page while logged in
    Given I am logged in as "cucumber"
    When I go to the login page
    Then I should be on the account page
    And I should see "You are already logged in."
    
  Scenario: Logging out
    Given I am logged in as "cucumber"
    When I follow "Sign Out"
    
    Then I should be on the login page
    And I should see "You have been logged out."

  Scenario: Editing account information
    Given I am logged in as "cucumber"
    And I am on the edit account page

    When I fill in "Email" with "newemail@example.com"
    And I fill in "username" with "newname"
    And I press "Update"
    
    Then I should be on the account page
    And I should see "Account updated!"
    And I should see "You haven't recorded any dreams yet."

  Scenario: Editing account with bad values
    Given I am logged in as "cucumber"
    And I am on the edit account page

    When I fill in "Email" with "NOT AN EMAIL"
    And I fill in "username" with ""
    And I press "Update"

    Then I should be on the failed edit account page
    And I should see "Email should look like an email address."
    And I should see "Username is too short (minimum is 3 characters)"
    And I should see "Username should use only letters, numbers, spaces, and .-_@ please."
