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
Board class >> assertValidDistance: distance [
	distance < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
]

{ #category : #asserting }
Board class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #asserting }
Board class >> assertValidNumberOfBox: box [
	box  > 1 ifFalse: [ Error signal: 'The box number must be valid' ].
]

{ #category : #asserting }
Board class >> assertValidNumberOfBoxes: boxes [
	boxes size > 1 ifFalse: [ Error signal: 'A board must have at least one box' ].
]

{ #category : #'class initialization' }
Board class >> players: ships withBoxes: aCollectionOfBoxes distance: aDistance and: laps [ 
	self assertValidNumberOfBoxes: aCollectionOfBoxes.
	self assertValidLaps:laps.
	self assertCollectionOfShipsIsValid:ships.
	self assertValidDistance: aDistance.
	^self new initializeWithPlayers: ships with:aCollectionOfBoxes distance: aDistance and:laps.
]

{ #category : #'instance creation' }
Board class >> players: ships withNoEffectsOf: aNumberOfBoxes distance: aDistance laps: laps [

	self assertValidNumberOfBox: aNumberOfBoxes.
	self assertValidLaps: laps.
	self assertValidDistance: aDistance.
	self assertCollectionOfShipsIsValid:ships.
	^ self new
		  initializeWithPlayers: ships
		  withNoEffectsOf: aNumberOfBoxes
		  distance: aDistance
		  laps: laps
]

{ #category : #instanceCreation }
Board class >> players: ships withOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes distance: aDistance laps: laps [

	self assertValidNumberOfBox: aNumberOfBox.
	self assertValidNumberOfBox: aNumberOfBoxes.
	self assertValidLaps: laps.
	self assertValidDistance: aDistance.
	self assertCollectionOfShipsIsValid: ships.
	^ self new
		  initializeWithPlayers: ships
		  withOnly: anEffect
		  at: aNumberOfBox
		  of: aNumberOfBoxes
		  distance: aDistance
		  laps: laps
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
Board >> initializeWithPlayers: ships with:aCollectionOfBoxes distance:aDistance and: numberOfLaps [

	boxes := aCollectionOfBoxes.
	laps := numberOfLaps.
	distancePerBox:= aDistance/(boxes size).
	positionController := PositionController for: ships
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
