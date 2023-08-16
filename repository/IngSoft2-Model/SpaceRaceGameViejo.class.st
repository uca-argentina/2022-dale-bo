Class {
	#name : #SpaceRaceGameViejo,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'turnSequence',
		'cardEffectApplier'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceRaceGameViejo class >> assertCollectionOfSpaceshipsIsValid: aCollectionOfSpaceships [

	aCollectionOfSpaceships size > 1 ifFalse: [ 
		Error signal: 'Game must have more than one Ship' ]
]

{ #category : #asserting }
SpaceRaceGameViejo class >> assertValidDistance: distance [

	distance negative ifTrue: [ 
		Error signal: 'A board must have a distance greater than zero' ]
]

{ #category : #asserting }
SpaceRaceGameViejo class >> assertValidLaps: laps [

	laps > 0 ifFalse: [ 
		Error signal: 'A board must have at least one lap' ]
]

{ #category : #'instance creation' }
SpaceRaceGameViejo class >> with: spaceships boardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps diceCup: aDiceCup and: aDeck [

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
SpaceRaceGameViejo >> allSpaceships [
	^board allSpaceships.
]

{ #category : #actions }
SpaceRaceGameViejo >> applyCardPlay: aCardPlay [
	
	
	cardEffectApplier apply:aCardPlay
]

{ #category : #actions }
SpaceRaceGameViejo >> assertGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, game has finished' ].
]

{ #category : #action }
SpaceRaceGameViejo >> distanceInBoxOf: aSpaceship [

	^ (board spaceshipOf:aSpaceship) position distanceInBox.
]

{ #category : #action }
SpaceRaceGameViejo >> handOf: aSpaceship [

	^ (board spaceshipOf:aSpaceship) hand.
]

{ #category : #accessing }
SpaceRaceGameViejo >> hasFinished [

	^ board thereIsAWinner.
]

{ #category : #initialize }
SpaceRaceGameViejo >> initializeWith: spaceships aBoardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps aDiceCup: aDiceCup and: aDeck [

	board := Board
		         ships: spaceships
		         with: aBoxSequence
		         distance: aDistance
		         laps: aNumberOfLaps
		         and: aDeck.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: spaceships.
	cardEffectApplier:= CardEffectApplicator with:board using:turnSequence.
]

{ #category : #actions }
SpaceRaceGameViejo >> playATurn [

	| diceResult currentSpaceship effectsOnCurrentSpaceship |
	self assertGameIsNotFinished.
	diceResult := diceCup roll.
	currentSpaceship := turnSequence whoPlays.
	effectsOnCurrentSpaceship := (board spaceshipOf: currentSpaceship)
		                        effectsOnSpaceship sumOfCardsEffects .
	board move: currentSpaceship with: diceResult + effectsOnCurrentSpaceship.
	turnSequence next
]

{ #category : #action }
SpaceRaceGameViejo >> positionOf: aSpaceship [

	^ (board spaceshipOf:aSpaceship) position.
]

{ #category : #action }
SpaceRaceGameViejo >> rankingOf: aShip [


			^ board rankingOf: aShip.
]

{ #category : #actions }
SpaceRaceGameViejo >> winner [

	^board winner.
]
