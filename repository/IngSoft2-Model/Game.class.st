Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'finished',
		'winner',
		'positions',
		'turnSequenceController'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertCollectionOfShipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']


]

{ #category : #'instance colors' }
Game class >> with: aCollectionOfShips a: aBoard and: aDiceCup [

	self assertCollectionOfShipsIsValid: aCollectionOfShips.
	^ self new initializeWith: aCollectionOfShips a: aBoard and: aDiceCup
]

{ #category : #accesing }
Game >> boxNumberOf: aShip [

	^( self positionOfShip:aShip) boxNumber. 
]

{ #category : #accessing }
Game >> hasFinished [

	^ finished
]

{ #category : #initializing }
Game >> initializeWith: aShips a: aBoard and: aDiceCup [

	positions := aShips collect: [ :ship | PositionOfAShip of: ship at: 0 and: 0].
	board := aBoard.
	diceCup := aDiceCup.
	turnSequenceController := TurnSequenceController with: aShips.
	finished := false
]

{ #category : #action }
Game >> playATurn [

	| shipNewBoxNumber shipNewLapNumber oldPosition |
	oldPosition := self positionOfShip: turnSequenceController whoPlays.
	shipNewBoxNumber := diceCup roll + oldPosition boxNumber.
	shipNewLapNumber := oldPosition lapNumber.
	oldPosition lapNumber < 2  "envez de 3 iria board lastLap"
		ifTrue: [ 
			(shipNewBoxNumber > board lastPosition) ifTrue: [ 
				shipNewLapNumber := oldPosition lapNumber  + 1 .
				shipNewBoxNumber := shipNewBoxNumber - board lastPosition ]]
		ifFalse: [ 
			(shipNewBoxNumber > board lastPosition) ifTrue: [ 
			shipNewBoxNumber := board lastPosition.
			finished := true.
			winner := turnSequenceController whoPlays ]].
	self update: oldPosition to: shipNewBoxNumber and: shipNewLapNumber.
	turnSequenceController changeTurn
]

{ #category : #action }
Game >> positionOfShip: aShip [

	^ positions detect: [ :each | each ownerShip = aShip ]
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
		positionOfShip1 boxNumber > positionOfShip2 boxNumber or: [ 
			positionOfShip1 boxNumber = positionOfShip2 boxNumber and:
				positionOfShip1 ownerShip < positionOfShip2 ownerShip ] ]
]

{ #category : #action }
Game >> update: oldPosition to: shipNewBoxNumber and: shipNewLapNumber [

	| newPosition |
	newPosition := PositionOfAShip
		               of: turnSequenceController whoPlays
		               at: shipNewBoxNumber
		               and: shipNewLapNumber.
	positions replaceAll: oldPosition with: newPosition.
]

{ #category : #actions }
Game >> winner [

	^ winner
]
