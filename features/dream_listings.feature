Feature:
  As a dream watcher
  I want to be able to see a list of dreams
  So that I can read them and attain peace

  Scenario: Listing recent dreams
    Given 20 numbered dreams have been recorded
    When I go to the dreams page
    Then I should see dreams 20 through 11
    And I should not see dream 10
    
    When I follow "Next"
    Then I should see dreams 10 through 1
    
    When I follow "Previous"
    Then I should see dreams 20 through 11

    When I follow "2"
    Then I should see dreams 10 through 1

    When I follow "1"
    Then I should see dreams 20 through 11

  Scenario: Listing recent anonymous dreams
    Given the following users exist:
      | username    |
      | cucumber    |
    And the following dreams exist:
      | description           | username    |
      | A cucumbers dream     | cucumber    |
      | Anonymous dream time  |             |
      | Anonymous dream time 2|             |

    When I go to the dreams page for the user "anonymous"
    Then I should not see "A cucumbers dream"
    And I should see "Anonymous dream time"
    And I should see "Anonymous dream time 2"

  Scenario: Listing recent dreams for a user
    Given the following users exist:
      | username       |
      | cucumber    |
      | melba_toast |
    And the following dreams exist:
      | description           | username       |
      | A cucumbers dream     | cucumber    |
      | The pickle nightmare  | cucumber    |
      | Anonymous dream time  |             |
      | Dazed and Confused..  | melba_toast |

    When I go to the dreams page for the user "cucumber"
    Then I should see "A cucumbers dream"
    And I should see "The pickle nightmare"
    And I should not see "Anonymous dream time"
    And I should not see "Dazed and Confused.."

  Scenario: Listing recent dreams by tag
    Given the following dreams exist:
      | description | dream_tags  | context_tags  |
      | Salmon      | fishy       |               |
      | Mahi Mahi   | fishy       |               |
      | Perennials  |             | fishy         |
      | Boorrinngg  |             |               |
      | Cows eCows  | landed      |               |

    When I go to the dreams page for the tag "fishy"
    Then I should see "Salmon"
    And I should see "Mahi Mahi"
    And I should see "Perennials"
    And I should not see "Boorrinngg"
    And I should not see "Cows eCows"

  Scenario: Listing recent dreams by year
    Given the following dreams exist:
      | description | created_at  |
      | 2009 1  | 2009-10-20  |
      | 2009 2  | 2009-10-22  |
      | 2008    | 2008-11-20  |
      | 2010    | 2010-11-20  |
    When I go to the dreams page for 2009
    Then I should see "2009 1"
    And I should see "2009 2"
    And I should not see "2008"
    And I should not see "2010"

  Scenario: Listing recent dreams by month
    Given the following dreams exist:
      | description | created_at  |
      | September   | 2009-09-20  |
      | October 1   | 2009-10-20  |
      | October 2   | 2009-10-22  |
      | November    | 2009-11-20  |

    When I go to the dreams page for 10/2009
    Then I should see "October 1"
    And I should see "October 2"
    And I should not see "September"
    And I should not see "November"

  Scenario: Listing recent dreams by day
    Given the following dreams exist:
      | description | created_at  |
      | Tuesday 1   | 2009-10-20  |
      | Tuesday 2   | 2009-10-20  |
      | Monday      | 2009-10-19  |
      | Wednesday   | 2009-10-21  |

    When I go to the dreams page for 10/20/2009
    Then I should see "Tuesday 1"
    And I should see "Tuesday 2"
    And I should not see "Monday"
    And I should not see "Wednesday"
