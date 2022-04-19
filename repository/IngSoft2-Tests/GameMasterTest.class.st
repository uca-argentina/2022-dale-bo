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
	| gameMaster player1 player2 ship1 ship2 setOfPlayers aBoard |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	ship2 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	gameMaster:= GameMaster withPlayers: setOfPlayers andBoard:aBoard.
	self assert: ((gameMaster whoPlays) = player1).
	self assert: ((gameMaster whoPlays) = player2).
	self assert: ((gameMaster whoPlays) = player1).
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithAnArrayOfOnePlayer [
	| player1  ship1  arrayOfPlayers aBoard |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	arrayOfPlayers:= Array new: 1.
	arrayOfPlayers at:1 put:player1.
	self 
		should: [  GameMaster withPlayers: arrayOfPlayers andBoard:aBoard]
		raise: Error
		withMessage: 'GameMaster must have an array of players with a size greater than one'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithAnArrayOfPlayers [

	| gameMaster player1 player2 ship1 ship2 setOfPlayers aBoard |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	ship2 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	gameMaster:= GameMaster withPlayers: setOfPlayers andBoard:aBoard.
	self assert: ((gameMaster getPlayers at: 2)  = player2).
	self deny: ((gameMaster getPlayers at: 1)  = player2).
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithAnArrayOfStrings [
	|  arrayOfPlayers aBoard |
	aBoard:= Board with:10.
	arrayOfPlayers:= Array new: 2.
	arrayOfPlayers at:1 put:'player1'.
	arrayOfPlayers at:1 put:'player2'.
	self 
		should: [ GameMaster withPlayers: arrayOfPlayers andBoard:aBoard.]
		raise: Error
		withMessage: 'GameMaster must have an array of players full of players'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithNoArrayOfPlayers [
	
	self 
		should: [ GameMaster withPlayers: '' andBoard:(Board with:10)]
		raise: Error
		withMessage: 'GameMaster must have an array of players with a size greater than one'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterIsCreatedWithNoBoard [
	|  player1 player2 ship1 ship2 setOfPlayers aBoard |
	
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	ship2 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	
	self 
		should: [ GameMaster withPlayers: setOfPlayers  andBoard:'']
		raise: Error
		withMessage: 'GameMaster must have a board'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterReturnsErrorWhenGameHasFinishAndSomeoneWantsToPlay [
	| gameMaster player1 player2 ship1 ship2 setOfPlayers aBoard die |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	ship2 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	die := LoadedDie with: 11.
	gameMaster:= GameMaster withPlayers: setOfPlayers andBoard:aBoard.
	(gameMaster whoPlays) moveItsShip: die.
	
		self
		should: [ (gameMaster whoPlays) moveItsShip: die.]
		raise: Error
		withMessage: 'Game has ended'.
]

{ #category : #tests }
GameMasterTest >> testGameMasterReturnsPositions [
	| gameMaster player1 player2 ship1 ship2 setOfPlayers aBoard dieOne dieTwo |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	ship2 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	gameMaster:= GameMaster withPlayers: setOfPlayers andBoard:aBoard.
	(gameMaster whoPlays) moveItsShip: dieOne.
	(gameMaster whoPlays) moveItsShip: dieTwo.
	
	self assert:(gameMaster getPositions at:player1) = 1.
	self assert:(gameMaster getPositions at:player2) = 2.
]

{ #category : #tests }
GameMasterTest >> testGameMasterReturnsWhoHasWon [
	| gameMaster player1 player2 ship1 ship2 setOfPlayers aBoard die |
	aBoard:= Board with:10.
	ship1 := Ship withBoard:aBoard.
	ship2 := Ship withBoard:aBoard.
	player1:=Player withName:'Valen' withShip:ship1.
	player2:=Player withName:'Pablo' withShip:ship2.
	setOfPlayers:= Array new: 2.
	setOfPlayers at: 1 put: player1.
	setOfPlayers at: 2 put: player2.
	die := LoadedDie with: 6.
	gameMaster:= GameMaster withPlayers: setOfPlayers andBoard:aBoard.
	(gameMaster whoPlays) moveItsShip: die.
	(gameMaster whoPlays) moveItsShip: die.
	(gameMaster whoPlays) moveItsShip: die.
	self assert:(gameMaster winner) = player1.
]
