Story: Viewing & creating timelines
 
  As a visitor
  I want to visit the timelines pages
  So that I can see timelines & create awesome new ones

  Scenario: viewing the timelines page when not logged in
    Given I am not logged in
    When I view the timelines page
    Then I see the page

  Scenario: viewing the timelines page when logged in
    Given I am not logged in
    When I view the timelines page
    Then I see the page
      And can create a new timeline

  Scenario: viewing a timeline when not logged in
    Given I am not logged in
      And the timeline exists
    When I view the timeline page
    Then I see the page

  Scenario: viewing somebody elses timeline when it isn't public
    Given I am logged in
      And the timeline exists
      And the timeline isn't public
      And I didn't create the timeline
    When I view the timeline page
    Then I see an unauthorised error

  Scenario: viewing my timeline when logged in
    Given I am logged in
      And the timeline exists
      And I created the timeline
    When I view the timeline page
    Then I see the page
      And can edit the timeline
