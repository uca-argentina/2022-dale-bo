Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps',
		'distanceOfBoard',
		'positionController',
		'distancePerBox'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertCollectionOfShipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']
]

{ #category : #asserting }
Board class >> assertValid: boxes [
	boxes isEmpty ifTrue: [ Error signal: 'A board must have at least one box' ].
]

{ #category : #asserting }
Board class >> assertValidDistance: distance [
	distance < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
]

{ #category : #asserting }
Board class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #asserting }
Board class >> assertValidNumberOfBoxes: boxes [
	boxes > 1 ifFalse: [ Error signal: 'A board must have at least one box' ].
]

{ #category : #'class initialization' }
Board class >> players: ships withBoxes: aCollectionOfBoxes and: laps [ 
	self assertValid: aCollectionOfBoxes.
	self assertValidLaps:laps.
	self assertCollectionOfShipsIsValid:ships.
	^self new initializeWith: ships a:aCollectionOfBoxes and:laps.
]

{ #category : #'instance creation' }
Board class >> players: ships withNoEffectsOf: aNumberOfBoxes distance: aDistance laps: laps [

	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidLaps: laps.
	self assertValidDistance: aDistance.
	^ self new
		  initializeWithPlayers: ships
		  withNoEffectsOf: aNumberOfBoxes
		  distance: aDistance
		  laps: laps
]

{ #category : #instanceCreation }
Board class >> players: ships withOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes distance: aDistance laps: laps [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidLaps: laps.
	self assertValidDistance: aDistance.
	^ self new
		  initializeWithPlayers: ships
		  withOnly: anEffect
 		  at: aNumberOfBox
		  of: aNumberOfBoxes
		  distance: aDistance
		  laps: laps
]

{ #category : #creation }
Board class >> withAll: aCollectionOfBoxes and: laps [

	self assertValid: aCollectionOfBoxes.
	self assertValidLaps: laps.
	^ self new initializeWith: aCollectionOfBoxes
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
		and: self laps
]

{ #category : #initialization }
Board >> initializeWith: aCollectionOfBoxes [

	boxes := aCollectionOfBoxes.
	laps := numberOfLaps
]

{ #category : #initialization }
Board >> initializeWith: ships a:aCollectionOfBoxes and: numberOfLaps [

	boxes := aCollectionOfBoxes.
	laps := numberOfLaps.
]

{ #category : #initialize }
Board >> initializeWithPlayers: ships withNoEffectsOf: aNumberOfBoxes distance: aDistance laps: aNumberOfLaps [

	boxes := (BoxesGenerator generateWithNoEffectsOf: aNumberOfBoxes)
		         boxSequence.
	distancePerBox := aDistance // boxes size.
	laps := aNumberOfLaps.
	positionController := PositionController for: ships
]

{ #category : #initialize }
Board >> initializeWithPlayers: ships withOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes distance: aDistance laps: aNumberOfLaps [

	boxes := (BoxesGenerator
		          generateWithOnly: anEffect
		          at: aNumberOfBox
		          of: aNumberOfBoxes) boxSequence.
	distancePerBox := aDistance // boxes size.
	laps := aNumberOfLaps.
	positionController := PositionController for: ships
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
	oldPosition := positionController positionOf: aShip.
	positionController
		moveForward: oldPosition ownerShip
		to: aDiceResult
		with: self lastPosition
		and: self laps.
	shipPositionWithoutEffect := positionController positionOf: aShip.
	self
		effectAt: shipPositionWithoutEffect boxNumber
		for: positionController
		appliedBy: shipPositionWithoutEffect ownerShip
]

{ #category : #accesing }
Board >> positionOf: aShip [

	^ positionController positionOf: aShip.
]

{ #category : #accesing }
Board >> rankingOf: aShip [

	positionController sortPositionsByRanking.
	positionController positions do: [ :positionOfAShip | 
		positionOfAShip ownerShip = aShip ifTrue: [ 
			^ positionController positions indexOf: positionOfAShip ] ]
]

{ #category : #accesing }
Board >> winner [

	^ positionController winner.
]
