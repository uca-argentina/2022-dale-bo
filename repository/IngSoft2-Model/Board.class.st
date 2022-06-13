Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps',
		'distanceOfBoard',
		'distancePerBox',
		'deck',
		'spaceshipsController'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertCollectionOfShipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']
]

{ #category : #asserting }
Board class >> assertValidDistance: distance [
	distance < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
]

{ #category : #asserting }
Board class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #'instance creation' }
Board class >> ships: spaceships with: aBoxSequence distance: aDistance laps: laps and: aDeck [


	^ self new
		  initializeWithShips: spaceships
		  with: aBoxSequence
		  distance: aDistance
		  laps: laps
		  and: aDeck
]

{ #category : #accessing }
Board >> allShips [
	^spaceshipsController positions.
]

{ #category : #accessing }
Board >> boxes [

	^ boxes
]

{ #category : #actions }
Board >> effectAt: aBoxNumber for: ships appliedBy: aShip [

	(boxes at: aBoxNumber)
		applyTo: ships
		triggeredBy: aShip
		with: self lastPosition
		distance: distancePerBox
		laps: self laps
]

{ #category : #initialization }
Board >> initializeWithShips: spaceships with: aBoxSequence distance: aDistance laps: numberOfLaps and: aDeck [
	boxes := aBoxSequence.
	distancePerBox := aDistance // (boxes size).
	laps := numberOfLaps.
	deck:= aDeck.
	spaceshipsController := SpaceshipsController for: spaceships and:deck.
	
]

{ #category : #accessing }
Board >> laps [

	^ laps
]

{ #category : #accesing }
Board >> lastPosition [

	^ boxes size
]

{ #category : #actions }
Board >> play: aShip with: aDiceResult [

	| oldPosition shipPositionWithoutEffect |
	oldPosition := spaceshipsController positionOf: aShip.
	spaceshipsController
		moveForward: oldPosition ownerShip
		to: aDiceResult
		with: self lastPosition
		and: self laps.
	shipPositionWithoutEffect := spaceshipsController positionOf: aShip.
	self
		effectAt: shipPositionWithoutEffect boxNumber
		for: spaceshipsController
		appliedBy: shipPositionWithoutEffect ownerShip
]

{ #category : #accesing }
Board >> positionOf: aShip [

	^ spaceshipsController positionOf: aShip.
]

{ #category : #accesing }
Board >> rankingOf: aShip [

	spaceshipsController sortPositionsByRanking.
	spaceshipsController positions do: [ :positionOfAShip | 
		positionOfAShip ownerShip = aShip ifTrue: [ 
			^ spaceshipsController positions indexOf: positionOfAShip ] ]
]

{ #category : #accesing }
Board >> winner [

	^ spaceshipsController winner.
]
