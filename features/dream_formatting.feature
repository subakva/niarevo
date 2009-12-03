Feature:
  As a dreamer
  In order to make my dreams easy to read
  I want to be able to use special text syntax

Scenario: Using markdown in a dream description
  Given I am on the new dream page
  When I fill in "Describe your dream" with "A **bold** flavor filled my maw"
  And I press "Save"

  Then I should be on the newest dream page
  And I should see "A bold flavor filled my maw"
  And I should see "bold" within "strong"
  And I should not see "<strong>bold</strong>"
  And I should not see "**bold**"

Scenario: Attempting to insert html
  Given I am on the new dream page
  When I fill in "Describe your dream" with "hi <script/>there"
  And I press "Save"

  Then I should be on the newest dream page
  And I should see "hi <script/>there"
  And I should not see "hi there"

Scenario: Markdown in the title
  Given I am on the new dream page
  When I fill in "Describe your dream" with "A **bold** flavor filled my maw"
  And I press "Save"

  Then I should be on the newest dream page
  And I should see "A bold flavor" within "title"
