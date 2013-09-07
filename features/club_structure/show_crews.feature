Feature: Show crews.

	All Blue Trolley club participants are organized into separate crews.
	In order to know the organizational structure of the club
	As Don Reba or Administrator
	I need to display the list of all registered crews.

	Scenario: Show all crews.
		Given a user Mary signed in as "Administrator" to Blue Troll application
		When Mary selects "Crews" menu item
		Then she can see the list of all registered crews
