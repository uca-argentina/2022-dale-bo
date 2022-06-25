Class {
	#name : #Board,
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
	^spaceships.
]

{ #category : #accessing }
Board >> boxes [

	^ boxes
]

{ #category : #action }
Board >> createStatusFor: aCollectionOfShips [

	| hand position spaceshipEffects cards |
	spaceships := aCollectionOfShips collect: [ :ship | 
		              cards := OrderedCollection new.
		              cards add: deck giveCard.
		              cards add: deck giveCard.
		              hand := SpaceshipHand with: cards.
		              position := SpaceshipPosition
			                          at: 1
			                          distance: 0
			                          laps: 1.
		              spaceshipEffects := SpaceshipEffects with:
			                                  OrderedCollection new.
		              SpaceshipStatus
			              of: ship
			              position: position
			              cards: hand
			              effects: spaceshipEffects ]
]

{ #category : #accessing }
Board >> effectAt: aBoxNumber for: ships appliedBy: aSpacehip [

	(boxes at: aBoxNumber) triggeredBy: aSpacehip with: self.
	lastBoxEffect := boxes at: aBoxNumber
]

{ #category : #actions }
Board >> giveTo: aSpaceship card: aCard [

	| aSpaceshipOldStatus  aSpaceshipHand |
	aSpaceshipOldStatus:= self spaceshipOf: aSpaceship.
	aSpaceshipHand:=  (aSpaceshipOldStatus hand)hand.
	aSpaceshipHand add:aCard.
	spaceships replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: (SpaceshipHand with:aSpaceshipHand)
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #initialization }
Board >> initializeWithShips: aCollectionOfSpaceships with: aBoxSequence distance: aDistance laps: numberOfLaps and: aDeck [
	boxes := aBoxSequence.
	distancePerBox := (aDistance amountInParsecs) / (boxes size).
	laps := numberOfLaps.
	deck:= aDeck.
	self createStatusFor:aCollectionOfSpaceships.
	lastBoxEffect := nil.
	winner:=nil.
]

{ #category : #accessing }
Board >> lastBoxEffect [
	^lastBoxEffect.
]

{ #category : #actions }
Board >> move: aSpaceship toFinalDistance: aDistanceNumber [ 
	| oldSpaceshipPosition  spaceshipNewDistanceInBox oldSpaceshipStatus |
	oldSpaceshipStatus := spaceships detect: [ :each | each nameOfSpaceship = aSpaceship ].
	oldSpaceshipPosition:= oldSpaceshipStatus position.
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distance + aDistanceNumber amountInParsecs.

	self updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % distancePerBox 
				 laps: oldSpaceshipPosition lapNumber).
	self
		moveForward: aSpaceship
		to: spaceshipNewDistanceInBox // distancePerBox 
]

{ #category : #actions }
Board >> move: aShip with: aDiceResult [

	| oldSpaceship spaceshipWithoutEffectsApplied |
	oldSpaceship := self spaceshipOf: aShip.
	self moveForward: oldSpaceship nameOfSpaceship to: aDiceResult.
	spaceshipWithoutEffectsApplied := (self spaceshipOf: aShip) position.
	self
		effectAt: spaceshipWithoutEffectsApplied boxNumber
		for: spaceships
		appliedBy: oldSpaceship name
]

{ #category : #actions }
Board >> moveBackwards: aNumberOfBoxes AllSpaceshipsExcept: aSpaceship [

	spaceships do: [ :each | 
		each nameOfSpaceship ~= aSpaceship ifTrue: [ 
			self moveBackwards: each name to: aNumberOfBoxes ] ].
]

{ #category : #accessing }
Board >> moveBackwards: aSpaceship to: aBox [

	| oldSpaceshipPosition spaceshipNewBoxNumber spaceshipNewLapNumber oldSpaceshipStatus|
	oldSpaceshipStatus := spaceships detect: [ :each | each nameOfSpaceship = aSpaceship ].
	oldSpaceshipPosition := oldSpaceshipStatus position.
	spaceshipNewBoxNumber := oldSpaceshipPosition boxNumber - aBox.
	spaceshipNewLapNumber := oldSpaceshipPosition lapNumber.
	
	spaceshipNewBoxNumber < 1 ifTrue:[
		spaceshipNewLapNumber:= oldSpaceshipPosition lapNumber - 1 max:1.
		spaceshipNewBoxNumber := boxes size + spaceshipNewBoxNumber].
	self
		updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distance
				 laps: spaceshipNewLapNumber)
]

{ #category : #accessing }
Board >> moveForward: aSpaceship to: aBox [

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

{ #category : #action }
Board >> moveSpaceshipsToTheFirstBox [
	spaceships do: [ :each | 
		self
		updateSpaceshipPositionOf: each
		to: (SpaceshipPosition
				 at: 1
				 distance: 0
				 laps: (each position) lapNumber) ].
]

{ #category : #accesing }
Board >> rankingOf: aSpaceship [

	self sortPositionsByRanking.
	spaceships do: [ :spaceship | 
		spaceship nameOfSpaceship = aSpaceship  ifTrue: [ 
			^ spaceships indexOf: spaceship ] ]
]

{ #category : #accessing }
Board >> sortPositionsByRanking [

	spaceships sort: [ :spaceshipStatus1 :spaceshipStatus2 | 
		(spaceshipStatus1 position) lapNumber > (spaceshipStatus2 position) lapNumber or: [ 
			(spaceshipStatus1 position) lapNumber = (spaceshipStatus2 position) lapNumber and:
				(spaceshipStatus1 position) boxNumber > (spaceshipStatus2 position) boxNumber ] ]
]

{ #category : #accesing }
Board >> spaceshipOf: aShipsName [

	^ spaceships detect: [ :each | each nameOfSpaceship = aShipsName ]
]

{ #category : #actions }
Board >> updateSpaceshipEffectsOf: aSpaceshipOldStatus to: spaceshipNewEffects [

	spaceships replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: aSpaceshipOldStatus hand
			 effects: spaceshipNewEffects ).
]

{ #category : #actions }
Board >> updateSpaceshipHandOf: aSpaceshipOldStatus with: spaceshipNewHand [

	spaceships replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: spaceshipNewHand
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #actions }
Board >> updateSpaceshipPositionOf: aSpaceshipOldStatus to: spaceshipNewPosition [

	spaceships replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: spaceshipNewPosition
			 cards: aSpaceshipOldStatus hand
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #accesing }
Board >> winner [

	 ^ winner
]
