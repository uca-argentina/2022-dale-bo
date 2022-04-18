Class {
	#name : #GameMaster,
	#superclass : #Object,
	#instVars : [
		'players',
		'turn',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
GameMaster class >> assertArrayOfPlayersIsAnArrayWithMoreThanOneSize:anArrayOfPlayers [.
	(anArrayOfPlayers className = 'Array' and: anArrayOfPlayers size > 1) ifFalse: [ 
		Error signal: 'GameMaster must have an array of players with a size greater than one']
]

{ #category : #asserting }
GameMaster class >> assertArrayOfPlayersIsFullOfPlayersObjects:anArrayOfPlayers [
	anArrayOfPlayers do:[:each | each className = 'Player' ifFalse: [Error signal: 'GameMaster must have an array of players full of players']]. 

]

{ #category : #asserting }
GameMaster class >> assertBoardIsValid: aBoard [ 
	aBoard className = 'Board' ifFalse: [ 
		Error signal: 'GameMaster must have a board']
]

{ #category : #'as yet unclassified' }
GameMaster class >> withPlayers: anArrayOfPlayers andBoard: aBoard [ 
	self assertArrayOfPlayersIsAnArrayWithMoreThanOneSize:anArrayOfPlayers.
	self assertArrayOfPlayersIsFullOfPlayersObjects:anArrayOfPlayers.
	self assertBoardIsValid: aBoard.
	^self new initializeWithPlayers: anArrayOfPlayers andInitWithBoard:aBoard.
]

{ #category : #'as yet unclassified' }
GameMaster >> getPlayers [
	 ^ players.
]

{ #category : #initialization }
GameMaster >> initializeWithPlayers: anArrayOfPlayers andInitWithBoard:aBoard [
	players := anArrayOfPlayers.
	turn := 1.
	board:= aBoard.
]

{ #category : #'as yet unclassified' }
GameMaster >> whoPlays [
	| activePlayer |
	activePlayer := (players at: turn).
	turn := turn +1.
	(turn > players size) ifTrue: [ turn:=1 ].
	^ activePlayer.
]
