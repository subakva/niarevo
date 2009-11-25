Feature:
  As an anonymous dreamer
  I want to be able to add my dreams to the site on the D/L
  So that I can contribute, but still protect my identity

  As a spammer
  I want to have my nasty spam rejected
  So that I can give up and spend my life doing something more constructive

Scenario: Anonymous user creating a dream
  Given I am on the new dream page

  When I fill in "Describe your dream" with "It was a stormy and dark night"
  And I fill in "Tag your dream" with "cliche, storm, night"
  And I press "Save"
  
  Then I should be on the newest dream page
  And I should see "Your dream has been saved."
  And I should see "It was a stormy and dark night"
  And I should see "Anonymous"
  And I should see "cliche"
  And I should see "storm"
  And I should see "night"
  And I should not see "[Edit]"

Scenario: Anonymous user attempting to edit a dream
  Given I have created a dream "It was a stormy and dark night"
  When I go to the edit dream page for my dream
  Then I should be on the login page
  And I should see "You must be logged in to access this page"
