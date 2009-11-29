Feature:
  As a compulsive tagger
  I want to be able to see only the dreams that are missing tags
  So that I can make things right

Background:
  Given the following dreams exist:
    | description | content_tags  | context_tags  |
    | NoContent   |               | fishy         |
    | NoContext   | fishy         |               |
    | HasNeither  |               |               |
    | HasAllKinds | fishy         | fishy         |

Scenario: Viewing dreams that have no tags
  When I go to the untagged dreams page
  Then I should see "HasNeither"
  And I should see "NoContent"
  And I should see "NoContext"
  And I should not see "HasAllKinds"
  
Scenario: Viewing dreams that have no content tags
  When I go to the dream page with description "NoContent"
  Then I should see "untagged" within ".content-tags"
  When I follow "untagged" within ".content-tags"

  Then I should be on the untagged content dreams page
  Then I should see "HasNeither"
  And I should see "NoContent"
  And I should not see "NoContext"
  And I should not see "HasAllKinds"
  
Scenario: Viewing dreams that have no context tags
  When I go to the dream page with description "NoContext"
  Then I should see "untagged" within ".context-tags"
  When I follow "untagged" within ".context-tags"

  Then I should be on the untagged context dreams page
  And I should see "HasNeither"
  And I should see "NoContext"
  And I should not see "NoContent"
  And I should not see "HasAllKinds"
  