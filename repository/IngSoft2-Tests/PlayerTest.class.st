Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerIsCreatedWithANameAndAtLeastOneShip [

	| player1 setOfShips ship1 ship2 |
	ship1:= Ship initialize.
	ship2:= Ship initialize.
	setOfShips:= Set new.
	setOfShips add: [ ship1. ship2 ].
	player1:=Player withName:'Valen' withShips:setOfShips.
	
	self assert:(player1 getName sameAs: 'Valen').
	self assert:(player1 getShips isNotEmpty). 

]

{ #category : #tests }
PlayerTest >> testPlayerMovesOneOfHisShips [

	| player1 setOfShips ship1 ship2 |
	ship1:= Ship initialize.
	ship2:= Ship initialize.
	setOfShips:= Set new.
	setOfShips add: [ ship1. ship2 ].
	player1:=Player withName:'Valen' withShips:setOfShips.
	player1 move: ship1 diceResult:4.
	self assert: (ship1 getPosition = 4).

]
