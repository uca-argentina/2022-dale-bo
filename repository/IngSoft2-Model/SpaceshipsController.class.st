Class {
	#name : #SpaceshipsController,
	#superclass : #Object,
	#instVars : [
		'winner',
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipsController class >> for: spaceships and: aDeck [

	^ self new initializeWith: spaceships and: aDeck
]

{ #category : #accesing }
SpaceshipsController >> allSpaceships [

	^ spaceships
]

{ #category : #accesing }
SpaceshipsController >> applyAtomicBomb [

	spaceships do: [ :each | 
		spaceships replaceAll: each with: (self
				 updateSpaceshipOf: each nameOfSpaceship
				 from: each
				 to: 1
				 and: each lapNumber) ]
]

{ #category : #action }
SpaceshipsController >> giveTo: aSpaceship card: aCard [

	(self spaceshipOf: aSpaceship) receive: aCard
]

{ #category : #initialization }
SpaceshipsController >> initializeWith: nameOfSpaceships and: aDeck [

	| hand |
	spaceships := nameOfSpaceships collect: [ :ship | 
		              hand := OrderedCollection new.
		              hand add: aDeck giveCard.
		              hand add: aDeck giveCard.
		              Spaceship
			              of: ship
			              at: 1
			              distance: 0
			              laps: 1
			              cards: hand
			              and: OrderedCollection new ].
	winner := nil
]

{ #category : #actions }
SpaceshipsController >> move: aSpaceship to: aDistanceInBox finalDistance: finalDistanceInBox with: endPosition and: laps [

	| oldSpaceship spaceshipNewDistanceInBox |
	oldSpaceship := spaceships detect: [ :each | 
		                each nameOfSpaceship = aSpaceship ].
	spaceshipNewDistanceInBox := oldSpaceship distanceInBox
	                             + aDistanceInBox amountInParsecs.
	spaceships replaceAll: oldSpaceship with: (Spaceship
			 of: aSpaceship
			 at: oldSpaceship boxNumber
			 distance: spaceshipNewDistanceInBox % finalDistanceInBox
			 laps: oldSpaceship lapNumber
			 cards: oldSpaceship hand
			 and: oldSpaceship effectsOnMe).
	self
		moveForward: aSpaceship
		to: spaceshipNewDistanceInBox // finalDistanceInBox
		with: endPosition
		and: laps
]

{ #category : #action }
SpaceshipsController >> moveBackwards: aSpaceship to: aBox with: endPosition and: laps [

	| oldSpaceship spaceshipNewBoxNumber spaceshipNewLapNumber |
	oldSpaceship := spaceships detect: [ :each | each nameOfSpaceship = aSpaceship ].
	spaceshipNewBoxNumber := oldSpaceship boxNumber - aBox.
	spaceshipNewLapNumber := oldSpaceship lapNumber.
	(spaceshipNewBoxNumber < 1 and: oldSpaceship lapNumber > 1) ifTrue: [ 
		spaceshipNewBoxNumber := endPosition + spaceshipNewBoxNumber.
		spaceshipNewLapNumber := oldSpaceship lapNumber - 1 ].
	(spaceshipNewBoxNumber < 1 and: oldSpaceship lapNumber = 1) ifTrue: [ 
		spaceshipNewBoxNumber := 1 ].

	spaceships replaceAll: oldSpaceship with: (self
			 updateSpaceshipOf: aSpaceship
			 from: oldSpaceship
			 to: spaceshipNewBoxNumber
			 and: spaceshipNewLapNumber)
]

{ #category : #action }
SpaceshipsController >> moveForward: aSpaceship to: aBox with: endPosition and: laps [

	| oldSpaceship spaceshipNewBoxNumber spaceshipNewLapNumber |
	oldSpaceship := spaceships detect: [ :each | 
		                each nameOfSpaceship = aSpaceship ].
	spaceshipNewBoxNumber := oldSpaceship boxNumber + aBox.
	(spaceshipNewBoxNumber > endPosition and:
		 oldSpaceship lapNumber = laps) ifTrue: [ 
		spaceshipNewBoxNumber := endPosition.
		winner := oldSpaceship nameOfSpaceship ].
	(spaceshipNewBoxNumber > endPosition and:
		 oldSpaceship lapNumber < laps)
		ifTrue: [ 
			spaceshipNewLapNumber := oldSpaceship lapNumber + 1.
			spaceshipNewBoxNumber := spaceshipNewBoxNumber - endPosition ]
		ifFalse: [ spaceshipNewLapNumber := oldSpaceship lapNumber ].
	spaceships replaceAll: oldSpaceship with: (self
			 updateSpaceshipOf: aSpaceship
			 from: oldSpaceship
			 to: spaceshipNewBoxNumber
			 and: spaceshipNewLapNumber)
]

{ #category : #accesing }
SpaceshipsController >> sortPositionsByRanking [

	spaceships sort: [ :positionOfShip1 :positionOfShip2 | 
		 positionOfShip1 lapNumber > positionOfShip2 lapNumber  or: [ positionOfShip1 lapNumber = positionOfShip2 lapNumber and: positionOfShip1 boxNumber  > positionOfShip2 boxNumber ]  ]
]

{ #category : #accesing }
SpaceshipsController >> spaceshipOf: aShipsName [

	^ spaceships detect: [ :each | each nameOfSpaceship = aShipsName ]
]

{ #category : #action }
SpaceshipsController >> updateSpaceshipOf: aShip from: oldPosition to: shipNewBoxNumber and: shipNewLapNumber [

	^ Spaceship
		  of: aShip
		  at: shipNewBoxNumber
		  distance: oldPosition distanceInBox
		  laps: shipNewLapNumber
		  cards: oldPosition hand
		  and: oldPosition effectsOnMe
]

{ #category : #accesing }
SpaceshipsController >> winner [

	^ winner
]
