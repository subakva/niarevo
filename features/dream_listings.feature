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
