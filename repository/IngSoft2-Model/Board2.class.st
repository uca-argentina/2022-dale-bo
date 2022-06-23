Class {
	#name : #Board2,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps',
		'distanceOfBoard',
		'distancePerBox',
		'deck',
		'lastBoxEffect',
		'spaceships',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board2 class >> assertCollectionOfSpaceshipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']
]

{ #category : #asserting }
Board2 class >> assertValidDistance: distance [
	distance < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
]

{ #category : #asserting }
Board2 class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #'instance creation' }
Board2 class >> ships: spaceships with: aBoxSequence distance: aDistance laps: laps and: aDeck [


	^ self new
		  initializeWithShips: spaceships
		  with: aBoxSequence
		  distance: aDistance
		  laps: laps
		  and: aDeck
]

{ #category : #accessing }
Board2 >> allSpaceships [
	^spaceships.
]

{ #category : #accessing }
Board2 >> boxes [

	^ boxes
]

{ #category : #action }
Board2 >> createPositionsFor: aCollectionOfShips [ 
	| hand position spaceshipEffects |
	spaceships := aCollectionOfShips collect: [ :ship | 
		              hand := SpaceshipHand with: {deck giveCard. deck giveCard}.
						  position:= SpaceshipPosition at:1 distance:0 laps:1.
						  spaceshipEffects:= SpaceshipEffects with: OrderedCollection new.
		              SpaceshipStatus
			              of: ship
			         		  position:position
			              cards: hand
			              effects: spaceshipEffects  ].
]

{ #category : #accessing }
Board2 >> distancePerBox [

	^ distancePerBox 
]

{ #category : #accessing }
Board2 >> effectAt: aBoxNumber for: ships appliedBy: aShip [

	(boxes at: aBoxNumber)
		applyTo: ships
		triggeredBy: aShip
		with: self.
	lastBoxEffect := boxes at:aBoxNumber.
]

{ #category : #initialization }
Board2 >> initializeWithShips: aCollectionOfSpaceships with: aBoxSequence distance: aDistance laps: numberOfLaps and: aDeck [
	boxes := aBoxSequence.
	distancePerBox := (aDistance amountInParsecs) // (boxes size).
	laps := numberOfLaps.
	deck:= aDeck.
	self createPositionsFor:aCollectionOfSpaceships.
	lastBoxEffect := nil.
	winner:=nil.
]

{ #category : #accessing }
Board2 >> laps [

	^ laps
]

{ #category : #accessing }
Board2 >> lastBoxEffect [
	^lastBoxEffect.
]

{ #category : #accessing }
Board2 >> move: aSpaceship to: aDistanceInBox finalDistance: finalDistanceInBox [

	| oldSpaceshipPosition  spaceshipNewDistanceInBox oldSpaceshipStatus |
	oldSpaceshipStatus := spaceships detect: [ :each | each nameOfSpaceship = aSpaceship ] position.
	oldSpaceshipPosition:= oldSpaceshipStatus position.
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distanceInBox + aDistanceInBox amountInParsecs.

	self updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % finalDistanceInBox
				 laps: oldSpaceshipPosition lapNumber).
	self
		moveForward: aSpaceship
		to: spaceshipNewDistanceInBox // finalDistanceInBox
]

{ #category : #actions }
Board2 >> move: aShip with: aDiceResult [

	| oldSpaceship spaceshipWithoutEffectsApplied |
	oldSpaceship := self spaceshipOf: aShip.
	self moveForward: oldSpaceship nameOfSpaceship to: aDiceResult.
	spaceshipWithoutEffectsApplied := (self spaceshipOf: aShip) position.
	self
		effectAt: spaceshipWithoutEffectsApplied boxNumber
		for: spaceships
		appliedBy: oldSpaceship name
]

{ #category : #accessing }
Board2 >> moveBackwards: aSpaceship to: aBox [

	| oldSpaceshipPosition spaceshipNewBoxNumber spaceshipNewLapNumber oldSpaceshipStatus|
	oldSpaceshipStatus := spaceships detect: [ :each | each nameOfSpaceship = aSpaceship ].
	oldSpaceshipPosition := oldSpaceshipStatus position.
	spaceshipNewBoxNumber := oldSpaceshipPosition boxNumber - aBox.
	spaceshipNewLapNumber := oldSpaceshipPosition lapNumber.
	
	(spaceshipNewBoxNumber < 1 and: oldSpaceshipPosition lapNumber > 1) ifTrue: [ 
		spaceshipNewBoxNumber := boxes size + spaceshipNewBoxNumber.
		spaceshipNewLapNumber := oldSpaceshipPosition lapNumber - 1 ].
	(spaceshipNewBoxNumber < 1 and: oldSpaceshipPosition lapNumber = 1) ifTrue: [ 
		spaceshipNewBoxNumber := 1 ].

	self
		updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distance
				 laps: spaceshipNewLapNumber)
]

{ #category : #accessing }
Board2 >> moveForward: aSpaceship to: aBox [

	| oldSpaceshipPosition spaceshipNewBoxNumber spaceshipNewLapNumber oldSpaceshipStatus |
	oldSpaceshipStatus := spaceships detect: [ :each | each nameOfSpaceship = aSpaceship ].
	oldSpaceshipPosition := oldSpaceshipStatus position.
	spaceshipNewBoxNumber := oldSpaceshipPosition boxNumber + aBox.
	(spaceshipNewBoxNumber > boxes size and:
		 oldSpaceshipPosition lapNumber = laps) ifTrue: [ 
		spaceshipNewBoxNumber := boxes size.
		winner := oldSpaceshipStatus name ].
	(spaceshipNewBoxNumber > boxes size and:
		 oldSpaceshipPosition lapNumber < laps)
		ifTrue: [ 
			spaceshipNewLapNumber := oldSpaceshipPosition lapNumber + 1.
			spaceshipNewBoxNumber := spaceshipNewBoxNumber - boxes size ]
		ifFalse: [ spaceshipNewLapNumber := oldSpaceshipPosition lapNumber ].
	self
		updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distance
				 laps: spaceshipNewLapNumber)
]

{ #category : #accesing }
Board2 >> rankingOf: aShip [

	spaceshipsController sortPositionsByRanking.
	spaceshipsController allSpaceships do: [ :spaceship | 
		spaceship nameOfSpaceship = aShip ifTrue: [ 
			^ spaceshipsController allSpaceships indexOf: spaceship ] ]
]

{ #category : #accesing }
Board2 >> sizeOfBoard [

	^ boxes size
]

{ #category : #accessing }
Board2 >> spaceshipController [
	^spaceshipsController.
]

{ #category : #accesing }
Board2 >> spaceshipOf: aShipsName [

	^ spaceships detect: [ :each | each nameOfSpaceship = aShipsName ]
]

{ #category : #actions }
Board2 >> updateSpaceshipPositionOf: aSpaceshipOldStatus to: spaceshipNewPosition [

	spaceships replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: spaceshipNewPosition
			 cards: aSpaceshipOldStatus hand
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #accesing }
Board2 >> winner [

	 ^ winner
]
