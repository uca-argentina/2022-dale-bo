Class {
	#name : #GameMasterTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameMasterTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
GameMasterTest >> testGameMasterGameOrder [
	| gameMaster player1 player2 ship1 ship2 setOfPlayers|
	ship1 := Ship initialize.
	ship2 := Ship initialize.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	gameMaster:= GameMaster withPlayers: setOfPlayers.
	self assert: ((gameMaster whoPlays) = player1).
	self assert: ((gameMaster whoPlays) = player2).
	self assert: ((gameMaster whoPlays) = player1).
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithAnArrayOfOnePlayer [
	| player1  ship1  arrayOfPlayers|
	ship1:= Ship initialize.
	player1:=Player withName:'Pablo' withShip:ship1.
	arrayOfPlayers:= Array new: 1.
	arrayOfPlayers at:1 put:player1.
	self 
		should: [ GameMaster withPlayers: arrayOfPlayers]
		raise: Error
		withMessage: 'GameMaster must have an array of players with a size greater than one'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithAnArrayOfPlayers [

	| gameMaster player1 player2 ship1 ship2 setOfPlayers|
	ship1 := Ship initialize.
	ship2 := Ship initialize.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	gameMaster:= GameMaster withPlayers: setOfPlayers.
	self assert: ((gameMaster getPlayers at: 2)  = player2).
	self deny: ((gameMaster getPlayers at: 1)  = player2).
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithAnArrayOfStrings [
	|  arrayOfPlayers|
	arrayOfPlayers:= Array new: 2.
	arrayOfPlayers at:1 put:'player1'.
	arrayOfPlayers at:1 put:'player2'.
	self 
		should: [ GameMaster withPlayers: arrayOfPlayers]
		raise: Error
		withMessage: 'GameMaster must have an array of players full of players'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithNoArrayOfPlayers [
	
	self 
		should: [ GameMaster withPlayers: '']
		raise: Error
		withMessage: 'GameMaster must have an array of players with a size greater than one'.
]
