Feature:
  As a dreamer
  I want to be able to tag the context of my dream
  So that I can know whether others are dreaming about the same things

Scenario: Creating a dream with content tags
  Given I am logged in as "cucumber"
  And I am on the home page

  When I follow "Add"
  Then I should be on the new dream page

  When I fill in "Describe your dream" with "It was a stormy and dark night"
  And I fill in "Tag your dream" with "cliche, storm, night"
  And I press "Save"

  Then I should be on the newest dream page
  And I should see "Your dream has been saved."
  And I should see "cliche" within ".content-tags"
  And I should see "storm" within ".content-tags"
  And I should see "night" within ".content-tags"

Scenario: Editing a dream with content tags
  Given I am logged in as "cucumber"
  And I have created a dream "It was a stormy and dark night"
  And I am on the dream details page for my dream

  When I follow "[Edit]"
  Then I should be on the edit dream page for my dream

  And I fill in "Tag your dream" with "falling"
  And I press "Save"

  Then I should be on the dream details page for my dream
  And I should see "Your dream has been saved."
  And I should see "falling" within ".content-tags"

Scenario: Listing recent dreams by content tag
  Given the following dreams exist:
    | description | content_tags  | context_tags  |
    | Salmon      | fishy         |               |
    | Mahi Mahi   | fishy         |               |
    | Perennials  |               | fishy         |
    | Boorrinngg  |               |               |
    | Cows eCows  | landed        |               |

  When I go to the dreams page for the content tag "fishy"
  Then I should see "Salmon"
  And I should see "Mahi Mahi"
  And I should not see "Perennials"
  And I should not see "Boorrinngg"
  And I should not see "Cows eCows"
