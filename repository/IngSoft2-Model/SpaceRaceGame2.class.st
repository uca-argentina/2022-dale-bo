Class {
	#name : #SpaceRaceGame2,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'turnSequence',
		'cardEffectApplier',
		'deck',
		'allSpaceshipsStatuses'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceRaceGame2 class >> assertCollectionOfSpaceshipsIsValid: aCollectionOfSpaceships [

	aCollectionOfSpaceships size > 1 ifFalse: [ 
		Error signal: 'Game must have more than one Ship' ]
]

{ #category : #asserting }
SpaceRaceGame2 class >> assertValidDistance: distance [

	distance negative ifTrue: [ 
		Error signal: 'A board must have a distance greater than zero' ]
]

{ #category : #asserting }
SpaceRaceGame2 class >> assertValidLaps: laps [

	laps > 0 ifFalse: [ 
		Error signal: 'A board must have at least one lap' ]
]

{ #category : #'instance creation' }
SpaceRaceGame2 class >> with: spaceships boardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps diceCup: aDiceCup and: aDeck [

	self assertCollectionOfSpaceshipsIsValid: spaceships.
	self assertValidLaps: aNumberOfLaps.
	self assertValidDistance: aDistance.
	^ self new
		  initializeWith: spaceships
		  aBoardWith: aBoxSequence
		  distance: aDistance
		  laps: aNumberOfLaps
		  aDiceCup: aDiceCup
		  and: aDeck
]

{ #category : #accessing }
SpaceRaceGame2 >> allSpaceships [
	^board allSpaceships.
]

{ #category : #actions }
SpaceRaceGame2 >> applyCardPlay: aCardPlay [
	
	
	cardEffectApplier apply:aCardPlay
]

{ #category : #actions }
SpaceRaceGame2 >> assertGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, game has finished' ].
]

{ #category : #actions }
SpaceRaceGame2 >> createStatusFor: aCollectionOfShips [

	| hand position spaceshipEffects cards |
	allSpaceshipsStatuses := aCollectionOfShips collect: [ :ship | 
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

{ #category : #action }
SpaceRaceGame2 >> distanceInBoxOf: aSpaceship [

	^ (board spaceshipOf:aSpaceship) position distanceInBox.
]

{ #category : #action }
SpaceRaceGame2 >> handOf: aSpaceship [

	^ (board spaceshipOf:aSpaceship) hand.
]

{ #category : #accessing }
SpaceRaceGame2 >> hasFinished [
	| spaceshipPositions |
	spaceshipPositions:= allSpaceshipsStatuses collect:[:each | each position ].
	^ board thereIsAWinnerWith:spaceshipPositions.
]

{ #category : #initialize }
SpaceRaceGame2 >> initializeWith: spaceships aBoardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps aDiceCup: aDiceCup and: aDeck [
	deck:= aDeck.
	self createStatusFor:spaceships.
	board := Board2
		         with: aBoxSequence
		         distance: aDistance
		         laps: aNumberOfLaps.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: spaceships.
	cardEffectApplier:= CardEffectApplicator with:board using:turnSequence.
]

{ #category : #actions }
SpaceRaceGame2 >> playATurn [

	| diceResult newSpaceshipPosition currentSpaceshipStatus |
	self assertGameIsNotFinished.
	diceResult := diceCup roll.
	currentSpaceshipStatus := self statusOf: turnSequence whoPlays.
	"effectsOnCurrentSpaceship := (board spaceshipOf: currentSpaceship)
		                        effectsOnSpaceship sumOfCardsEffects ."
	newSpaceshipPosition:=board move: currentSpaceshipStatus position to: diceResult.
	self updateSpaceshipPositionOf: currentSpaceshipStatus to: newSpaceshipPosition.
	self sortPositionsByRanking.
	turnSequence next
]

{ #category : #action }
SpaceRaceGame2 >> positionOf: aSpaceship [

	^ (allSpaceshipsStatuses detect: [ :each | each name = aSpaceship ]) position
]

{ #category : #action }
SpaceRaceGame2 >> rankingOf: aShip [


			^ board rankingOf: aShip.
]

{ #category : #actions }
SpaceRaceGame2 >> sortPositionsByRanking [

	allSpaceshipsStatuses sort: [ :spaceship1 :spaceship2 | 
		spaceship1 position > spaceship2 position ]
]

{ #category : #action }
SpaceRaceGame2 >> statusOf: aSpaceship [

	^ (allSpaceshipsStatuses detect: [ :each | each name = aSpaceship ])
]

{ #category : #action }
SpaceRaceGame2 >> updateSpaceshipPositionOf: aSpaceshipOldStatus to: spaceshipNewPosition [


	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: spaceshipNewPosition
			 cards: aSpaceshipOldStatus hand
			 effects: aSpaceshipOldStatus effectsOnSpaceship).
]

{ #category : #actions }
SpaceRaceGame2 >> winner [

	^board winner.
]
