Feature:
  As a user of niarevo
  I want to be able to read dreams without sorting through spam
  So that I can maintain healthy blood pressure

Scenario: Activating by email
  Given I have registered an account
  Then I should receive an email
  When I open the email
  Then I should see "http://localhost:3000/activations/[\w-]*/edit" in the email body
  When I go to my activation page
  Then I should see "Your account is now activated! Please sign in."
  When I fill in "Username" with "cucumber"
  And I fill in "Password" with "password"
  And I press "Sign In"
  Then I should be on the account page

Scenario: Attempting to sign in to an inactive account
  Given I have registered an account
  And a clear email queue

  When I go to the login page
  And I fill in "Username" with "cucumber"
  And I fill in "Password" with "password"
  And I press "Sign In"

  Then I should be on the failed login page
  And I should see "Your account has not been activated yet."
  And I should see "Need a new activation email?"

  When I follow "Need a new activation email?"
  Then I should be on the activation page

  When I press "Send Activation Email"
  Then I should be on the activation index page
  And I should see "An activation key was sent by email. Follow the link in the email to activate your account."
  And I should receive an email

  When I open the email
  Then I should see "http://localhost:3000/activations/[\w-]*/edit" in the email body

  When I go to my activation page
  Then I should see "Your account is now activated! Please sign in."

Scenario: Attempting to activate an account with an invalid key
  Given I have registered an account
  When I go to the wrong activation page
  Then I should see "Sorry, we couldn't find that account."
  And I should be on the login page

Scenario: Attempting to activate an account that is already active
  Given I have activated an account for "cucumber"
  And I am on the activation page

  When I fill in "Username or email" with "cucumber"
  And I press "Send Activation Email"

  Then I should see "Your account is already active. Maybe you need to reset your password?"
  And I should be on the password reset page

Scenario: Attempting to reset a password for an account that doesn't exist
  Given I am on the activation page

  When I fill in "Username or email" with "notauser@example.com"
  And I press "Send Activation Email"

  Then I should see "Sorry, we couldn't find that account. Check for typos and try again."
