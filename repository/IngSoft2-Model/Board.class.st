Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps',
		'distanceOfBoard',
		'distancePerBox',
		'deck',
		'spaceshipsController',
		'lastBoxEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertCollectionOfSpaceshipsIsValid:aCollectionOfShips [

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
Board >> allSpaceships [
	^spaceshipsController allSpaceships.
]

{ #category : #accessing }
Board >> boxes [

	^ boxes
]

{ #category : #accesing }
Board >> distancePerBox [

	^ distancePerBox 
]

{ #category : #actions }
Board >> effectAt: aBoxNumber for: ships appliedBy: aShip [

	(boxes at: aBoxNumber)
		applyTo: ships
		triggeredBy: aShip
		with: self sizeOfBoard
		distance: distancePerBox
		laps: self laps.
	lastBoxEffect := boxes at:aBoxNumber.
]

{ #category : #initialization }
Board >> initializeWithShips: spaceships with: aBoxSequence distance: aDistance laps: numberOfLaps and: aDeck [
	boxes := aBoxSequence.
	distancePerBox := (aDistance amountInParsecs) // (boxes size).
	laps := numberOfLaps.
	deck:= aDeck.
	spaceshipsController := SpaceshipsController for: spaceships and:deck.
	lastBoxEffect := nil.
	
]

{ #category : #accessing }
Board >> laps [

	^ laps
]

{ #category : #accessing }
Board >> lastBoxEffect [
	^lastBoxEffect.
]

{ #category : #actions }
Board >> move: aShip with: aDiceResult [

	| oldSpaceship spaceshipWithoutEffectsApplied |
	oldSpaceship := spaceshipsController spaceshipOf: aShip.
	spaceshipsController
		moveForward: oldSpaceship nameOfSpaceship
		to: aDiceResult
		with: self sizeOfBoard
		and: self laps.
	spaceshipWithoutEffectsApplied := spaceshipsController spaceshipOf:
		                                  aShip.
	self
		effectAt: spaceshipWithoutEffectsApplied boxNumber
		for: spaceshipsController
		appliedBy: spaceshipWithoutEffectsApplied nameOfSpaceship
]

{ #category : #accesing }
Board >> rankingOf: aShip [

	spaceshipsController sortPositionsByRanking.
	spaceshipsController allSpaceships do: [ :spaceship | 
		spaceship nameOfSpaceship = aShip ifTrue: [ 
			^ spaceshipsController allSpaceships indexOf: spaceship ] ]
]

{ #category : #accesing }
Board >> sizeOfBoard [

	^ boxes size
]

{ #category : #accessing }
Board >> spaceshipController [
	^spaceshipsController.
]

{ #category : #accesing }
Board >> spaceshipOf: aShipsName [

	^ spaceshipsController spaceshipOf: aShipsName
]

{ #category : #accesing }
Board >> winner [

	^ spaceshipsController winner.
]
