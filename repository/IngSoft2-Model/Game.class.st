Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'finished',
		'winner',
		'turnSequenceController',
		'positionController'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance colors' }
Game class >> with: ships a: aBoard and: aDiceCup [

	^ self new initializeWith: ships a: aBoard and: aDiceCup
]

{ #category : #accesing }
Game >> boxNumberOf: aShip [

	^( self positionOfShip:aShip) boxNumber. 
]

{ #category : #accessing }
Game >> hasFinished [

	^(self winner equals: 'No one') 
]

{ #category : #initializing }
Game >> initializeWith: aShips a: aBoard and: aDiceCup [

	positionController := PositionController for:aShips.
	board := aBoard.
	diceCup := aDiceCup.
	turnSequenceController := TurnSequenceController with: aShips.
	finished := false
]

{ #category : #'instance creation' }
Game >> newPositionWith: oldPosition and: effect [

	| shipNewLapNumber shipNewBoxNumber |
	shipNewBoxNumber := oldPosition boxNumber + effect.
	shipNewLapNumber := oldPosition lapNumber.
	 ((shipNewBoxNumber <= 0 and: shipNewLapNumber < 2) or: (effect = (0-board lastPosition) ) )  ifTrue: [ 
		shipNewBoxNumber := 1 ].
	( shipNewBoxNumber < 0 and: (shipNewLapNumber > 1 and: effect ~= (0-board lastPosition))) ifTrue: [ 
		shipNewBoxNumber := board numberOfBoxes + shipNewBoxNumber.
		shipNewLapNumber := shipNewLapNumber - 1. ].

	oldPosition lapNumber < board laps
		ifTrue: [ 
			shipNewBoxNumber > board lastPosition ifTrue: [ 
				shipNewLapNumber := oldPosition lapNumber + 1.
				shipNewBoxNumber := shipNewBoxNumber - board lastPosition ] ]
		ifFalse: [ 
			shipNewBoxNumber >= board lastPosition ifTrue: [ 
				shipNewBoxNumber := board lastPosition.
				finished := true.
				winner := oldPosition ownerShip ] ].
	^ PositionOfAShip
		  of: oldPosition ownerShip 
		  at: shipNewBoxNumber
		  and: shipNewLapNumber
]

{ #category : #action }
Game >> playATurn [

	| oldPosition targetedShips effect positionWithoutEffect |
	oldPosition := self positionOfShip: turnSequenceController whoPlays.
	positionWithoutEffect := self
		                         newPositionWith: oldPosition
		                         and: diceCup roll.
	self update: oldPosition to: positionWithoutEffect.
	targetedShips := board
		                 effectAt: positionWithoutEffect boxNumber
		                 for: positions
		                 appliedBy: positionWithoutEffect .
	effect := board effectAt: positionWithoutEffect boxNumber.
	targetedShips do: [ :each | 
		self update: each to: (self newPositionWith: each and: effect) ].
	turnSequenceController changeTurn
]

{ #category : #actions }
Game >> playATurn2 [

	| oldPosition diceResult shipPositionWithoutEffect |
	oldPosition := positionController positionOf:
		               turnSequenceController whoPlays.
	diceResult := diceCup roll.
	positionController
		moveForward: oldPosition ownerShip
		to: diceResult
		with: board lastPosition and: board laps.
	shipPositionWithoutEffect := positionController positionOf:
		                             turnSequenceController whoPlays.
	board
		effectAt: shipPositionWithoutEffect boxNumber
		for: positionController
		appliedBy: shipPositionWithoutEffect ownerShip.

	turnSequenceController changeTurn
]

{ #category : #action }
Game >> positionOfShip: aShip [

	^ positionController positionOf:aShip.
]

{ #category : #action }
Game >> rankingOf: aShip [

	self sortPositionsByRanking.
	positions do: [ :positionOfAShip | 
		positionOfAShip ownerShip = aShip ifTrue: [ 
			^ positions indexOf: positionOfAShip ] ]
]

{ #category : #action }
Game >> sortPositionsByRanking [

	positions sort: [ :positionOfShip1 :positionOfShip2 | 
		 positionOfShip1 lapNumber > positionOfShip2 lapNumber  or: [ positionOfShip1 lapNumber = positionOfShip2 lapNumber and: positionOfShip1 boxNumber  > positionOfShip2 boxNumber ]  ]
]

{ #category : #actions }
Game >> update: lastPosition to: newPosition [

   
    positions replaceAll: lastPosition with: newPosition.
]

{ #category : #actions }
Game >> winner [

	^ positionController winner.
]
