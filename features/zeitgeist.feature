Scenario: Something
  Given the following dreams exist:
    | description | created_at  | content_tags  |
    | Today 1     | today       | today, first  |
    | Today 2     | today       | today, second |
    | Other 1     | 2009-10-22  | other, first  |
    | Other 2     | 2009-11-20  | other, second |
  And I am on the zeitgeist page

  Then I should see "today" within "#zeitgeist-today"
  And I should see "first" within "#zeitgeist-today"
  And I should see "second" within "#zeitgeist-today"

  And I should see "today" within "#zeitgeist-overall"
  And I should see "other" within "#zeitgeist-overall"
  And I should see "first" within "#zeitgeist-overall"
  And I should see "second" within "#zeitgeist-overall"

  