Feature: New Client Session

  In order to start a new session with the youTrack Server
  As a Client
  I should be able to connect to the remote host

  Scenario: starting a new session
    Given I create a new Client
    When I set the Client url to point to the Server
      And I enter the correct login credentials
      And I connect ok
    Then I should be connected to the Server

  Scenario: failing to start a new session
    Given I create a new Client
    When I set the Client url to point to the Server
      And I enter incorrect login credentials
      And I connect with error
    Then I should receive an error Response
