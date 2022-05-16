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

{ #category : #accessing }
Game >> hasFinished [

	^(self winner) ~= 'No one'. 
]

{ #category : #initializing }
Game >> initializeWith: aShips a: aBoard and: aDiceCup [

	positionController := PositionController for:aShips.
	board := aBoard.
	diceCup := aDiceCup.
	turnSequenceController := TurnSequenceController with: aShips.
	finished := false
]

{ #category : #actions }
Game >> playATurn [

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
	
	positionController sortPositionsByRanking.
	positionController positions do: [ :positionOfAShip | 
		positionOfAShip ownerShip = aShip ifTrue: [ 
			^ (positionController positions) indexOf: positionOfAShip ] ]
]

{ #category : #actions }
Game >> winner [

	^ positionController winner.
]
