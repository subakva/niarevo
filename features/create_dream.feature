Feature:
  As a dreamer
  In order to remember what dreams I've had
  I want to be able to describe a dream on the site

Scenario: Registered user creating a dream
  Given I am logged in as "cucumber"
  And I am on the home page
  
  When I follow "Add"
  Then I should be on the new dream page

  When I fill in "Describe your dream" with "It was a stormy and dark night"
  And I fill in "Tag your dream" with "cliche, storm, night"
  And I press "Save"
  
  Then I should be on the newest dream page
  And I should see "Your dream has been saved."
  And I should see "It was a stormy and dark night"
  And I should see "cucumber" within ".dream-user"
  And I should see "cliche" within ".dream-tags"
  And I should see "storm" within ".dream-tags"
  And I should see "night" within ".dream-tags"
  And I should see "[Edit]"

Scenario: Editing a dream
  Given I am logged in as "cucumber"
  And I have created a dream "It was a stormy and dark night"
  And I am on the dream details page for my dream

  When I follow "[Edit]"
  Then I should be on the edit dream page for my dream

  When I fill in "Describe your dream" with "I was falling down a deep, dark well"
  And I press "Save"

  Then I should be on the dream details page for my dream
  And I should see "Your dream has been saved."
  And I should see "I was falling down a deep, dark well"

Scenario: Attempting to create a dream with no description
  Given I am on the new dream page

  When I fill in "Describe your dream" with ""
  And I press "Save"

  Then I should be on the new dream error page
  And I should see "Description can't be blank"

Scenario: Attempting to edit a dream with no description
  Given I am logged in as "cucumber"
  And I have created a dream "It was a stormy and dark night"
  And I am on the edit dream page for my dream

  When I fill in "Describe your dream" with ""
  And I press "Save"

  Then I should be on the edit dream error page for my dream
  And I should see "Description can't be blank"
  
Scenario: Logged in user attempting to edit someone else's dream
  Given I am logged in as "cucumber"
  And I have created a dream "It was a stormy and dark night"
  And I follow "Sign Out"

  Given I am logged in as "pickle"
  When I go to the edit dream page for my dream
  Then I should be on the account page
  And I should see "You are not allowed to edit that dream"

  