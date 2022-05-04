Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'ships',
		'diceCup',
		'finished',
		'winner',
		'positions',
		'turnController'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertCollectionOfShipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']


]

{ #category : #'instance colors' }
Game class >> withPlayers: aCollection aBoard: aBoard andDiceCup: aDiceCup [ 
	^self new initializeWithPlayers:aCollection aBoard:aBoard andDiceCup:aDiceCup.
]

{ #category : #accessing }
Game >> hasFinished [
	^ finished.
]

{ #category : #initializing }
Game >> initializeWithPlayers: aShips aBoard: aBoard andDiceCup: aDiceCup [ 
	positions := aShips collect: [ :ship |Position of: ship at:0 ].
	board:= aBoard.
	diceCup:= aDiceCup.
	turnController:= TurnController withShips:aShips.
	finished:= false.
	
]

{ #category : #action }
Game >> playATurn [

	| shipNewBoxNumber newPosition oldPosition |
	oldPosition := self positionOfCurrentShip.
	shipNewBoxNumber := diceCup roll + oldPosition boxNumber.
	shipNewBoxNumber >= board lastPosition ifTrue: [ 
		shipNewBoxNumber := board lastPosition.
		finished := true.
		winner := turnController whoPlays ].
	newPosition := Position
		               of: turnController whoPlays
		               at: shipNewBoxNumber.
	positions at: (positions indexOf: oldPosition) put: newPosition.
	turnController changeTurn
]

{ #category : #accesing }
Game >> positionOf: aShipsName [
	
	positions do: [ :each | ((each owner) = aShipsName) ifTrue:[^each boxNumber] ].

]

{ #category : #action }
Game >> positionOfCurrentShip [

	^ positions detect: [ :each | each owner = turnController whoPlays ]
]

{ #category : #actions }
Game >> winner [
	^ winner.
]
