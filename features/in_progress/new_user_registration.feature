Feature: New user registration

  Any anonimous person
  Has ability to register herself in Blue Troll application
  So that she can be participant of Blue Trolley event

  Scenario: successful registration (happy path)
    Given the person who is not registered
    When the user visits Blue Troll home page
    And she starts new user registration process
    And she fills up the registration form correctly
    Then the new user account is created
    And the user sees congratulation message and account activation instructions
    And she receives the email with activation code and activation link
