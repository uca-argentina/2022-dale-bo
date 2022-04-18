Class {
	#name : #GameMaster,
	#superclass : #Object,
	#instVars : [
		'players',
		'turn'
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

{ #category : #'as yet unclassified' }
GameMaster class >> withPlayers: anArrayOfPlayers [
	self assertArrayOfPlayersIsAnArrayWithMoreThanOneSize:anArrayOfPlayers.
	self assertArrayOfPlayersIsFullOfPlayersObjects:anArrayOfPlayers.
	^self new initializeWithPlayers: anArrayOfPlayers.
]

{ #category : #'as yet unclassified' }
GameMaster >> getPlayers [
	 ^ players.
]

{ #category : #initialization }
GameMaster >> initializeWithPlayers: anArrayOfPlayers [
	players := anArrayOfPlayers.
	turn := 1.
]

{ #category : #'as yet unclassified' }
GameMaster >> whoPlays [
	| activePlayer |
	activePlayer := (players at: turn).
	turn := turn +1.
	(turn > players size) ifTrue: [ turn:=1 ].
	^ activePlayer.
]
