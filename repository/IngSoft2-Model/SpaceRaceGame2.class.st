Class {
	#name : #SpaceRaceGame2,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'turnSequence',
		'cardEffectApplier',
		'deck',
		'allSpaceshipsStatuses',
		'boxEffectApplicator'
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
SpaceRaceGame2 >> createHandFor: aCollectionOfShips [

	| hand spaceshipEffects cards allSpaceshipsHands |
	allSpaceshipsHands := aCollectionOfShips collect: [ :ship | 
		              cards := OrderedCollection new.
		              cards add: deck giveCard.
		              cards add: deck giveCard.
		              hand := SpaceshipHand with: cards.
		              spaceshipEffects := SpaceshipEffects with:
			                                  OrderedCollection new.]
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
	^ board thereIsAWinner.
]

{ #category : #initialize }
SpaceRaceGame2 >> initializeWith: spaceships aBoardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps aDiceCup: aDiceCup and: aDeck [
	deck:= aDeck.
	boxEffectApplicator:=BoxEffectsApplicator new.
	self createHandFor:spaceships.
	board := Board2
		         ships: spaceships
		         with: aBoxSequence
		         distance: aDistance
		         laps: aNumberOfLaps.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: spaceships.
	cardEffectApplier:= CardEffectApplicator with:board using:turnSequence.
]

{ #category : #actions }
SpaceRaceGame2 >> playATurn [

	| diceResult |
	self assertGameIsNotFinished.
	diceResult := diceCup roll.
	"effectsOnCurrentSpaceship := (board spaceshipOf: currentSpaceship)
		                        effectsOnSpaceship sumOfCardsEffects ."
	board move: turnSequence whoPlays with: diceResult.
	turnSequence next
]

{ #category : #actions }
SpaceRaceGame2 >> playATurn2 [

	| diceResult position |
	self assertGameIsNotFinished.
	diceResult := diceCup roll.
	"effectsOnCurrentSpaceship := (board spaceshipOf: currentSpaceship)
		                        effectsOnSpaceship sumOfCardsEffects ."
	position:= board moveDef: turnSequence whoPlays to: diceResult.
	boxEffectApplicator applyTo:position.
	turnSequence next
]

{ #category : #action }
SpaceRaceGame2 >> positionOf: aSpaceship [

	^ board positionOf:aSpaceship.
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
