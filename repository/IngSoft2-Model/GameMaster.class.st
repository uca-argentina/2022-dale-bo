Class {
	#name : #GameMaster,
	#superclass : #Object,
	#instVars : [
		'players',
		'turn',
		'board',
		'theresAWinner'
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

{ #category : #accesing }
GameMaster >> allPositions [
		| dict |
	dict:=Dictionary new.
	self players do:[:each | dict at:each put:((each ship) positionOf)].
	^ dict.
]

{ #category : #initialization }
GameMaster >> initializeWithPlayers: anArrayOfPlayers andInitWithBoard:aBoard [
	players := anArrayOfPlayers.
	turn := 1.
	theresAWinner :=false.
	board:= aBoard.
]

{ #category : #accesing }
GameMaster >> players [
	 ^ players.
]

{ #category : #action }
GameMaster >> whoPlays [
	| activePlayer |
	(board state) ifFalse:[Error signal: 'Game has ended'].
	activePlayer := (players at: turn).
	turn := turn +1.
	
	(turn > players size) ifTrue: [ turn:=1 ].
	^ activePlayer.
]

{ #category : #accesing }
GameMaster >> winner [
	| winner |
	winner:= players detect:[:each | ((each ship) positionOf) = board lastPosition] ifNone: [^false].
	theresAWinner:=true.
	^winner
]
