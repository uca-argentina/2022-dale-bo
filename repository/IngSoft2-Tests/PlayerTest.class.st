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

	| player1  ship1  |
	ship1:= Ship initialize.
	player1:=Player withName:'Valen' withShip:ship1.
	
	self assert:(player1 getName sameAs: 'Valen').
	self assert:(player1 getShip =ship1). 

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
	| ship1 |
	ship1 := Ship initialize.
	
	self 
		should: [ Player withName:'' withShip:ship1]
		raise: Error
		withMessage: 'Name must have at least one character and be a string'
]

{ #category : #tests }
PlayerTest >> testPlayerMovesHisShip [

	| player1 ship1 |
	ship1:= Ship initialize.
	player1:=Player withName:'Valen' withShip:ship1.
	player1 moveItsShip:4.
	self assert: (ship1 getPosition = 4).

]
