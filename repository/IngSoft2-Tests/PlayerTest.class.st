Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
PlayerTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
PlayerTest >> testPlayerIsCreatedWithANameAndOneShip [

	| player1  ship1  aBoard |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	
	self assert:(player1 name sameAs: 'Valen').
	self assert:(player1 ship) equals: ship1. 

]

{ #category : #tests }
PlayerTest >> testPlayerIsCreatedWithNameAndNoShip [
	
	self 
		should: [ Player withName:'Valen' withShip: '']
		raise: Error
		withMessage: 'Player must have a ship as gamepiece'
]

{ #category : #tests }
PlayerTest >> testPlayerIsCreatedWithNoNameAndOneShip [
	| ship1 aBoard |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	
	self 
		should: [ Player withName:'' withShip:ship1]
		raise: Error
		withMessage: 'Name must have at least one character and be a string'
]

{ #category : #tests }
PlayerTest >> testPlayerMovesHisShip [

	| player1 ship1 aBoard dieOne dieTwo dieThree aDiceCup |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { dieOne. dieTwo. dieThree }.
	player1 moveItsShip:aDiceCup.
	self assert: (ship1 positionOf) equals: 6.

]
