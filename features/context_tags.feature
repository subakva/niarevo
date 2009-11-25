Feature:
  As a dreamer
  I want to be able to tag the context of my dream
  So that I can know what other people are dreaming in similar situations

Scenario: Creating a dream with context
  Given I am logged in as "cucumber"
  And I am on the new dream page

  When I fill in "Describe your dream" with "I saw dogs and cats living together"
  And I fill in "Tag your context" with "ghostbusters, spicy-food"
  And I press "Save"

  Then I should be on the newest dream page
  And I should see "Your dream has been saved."
  And I should see "ghostbusters" within ".context-tags"
  And I should see "spicy-food" within ".context-tags"

Scenario: Editing a dream with context
  Given I am logged in as "cucumber"
  And I have created a dream "It was a stormy and dark night"
  And I am on the dream details page for my dream

  When I follow "[Edit]"
  Then I should be on the edit dream page for my dream

  And I fill in "Tag your context" with "in-a-boat"
  And I press "Save"

  Then I should be on the dream details page for my dream
  And I should see "Your dream has been saved."
  And I should see "in-a-boat" within ".context-tags"

Scenario: Listing recent dreams by context tag
  Given the following dreams exist:
    | description | dream_tags  | context_tags  |
    | Salmon      |             | fishy         |
    | Mahi Mahi   |             | fishy         |
    | Perennials  | fishy       |               |
    | Boorrinngg  |             |               |
    | Cows eCows  | landed      |               |

  When I go to the dreams page for the context tag "fishy"
  Then I should see "Salmon"
  And I should see "Mahi Mahi"
  And I should not see "Perennials"
  And I should not see "Boorrinngg"
  And I should not see "Cows eCows"
