Class {
	#name : #SpaceRaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'finished',
		'turnSequence',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceRaceGame class >> assertCollectionOfSpaceshipsIsValid: aCollectionOfSpaceships [

	aCollectionOfSpaceships size > 1 ifFalse: [ 
		Error signal: 'Game must have more than one Ship' ]
]

{ #category : #asserting }
SpaceRaceGame class >> assertValidDistance: distance [

	distance amount < 1 ifTrue: [ 
		Error signal: 'A board must have a distance greater than zero' ]
]

{ #category : #asserting }
SpaceRaceGame class >> assertValidLaps: laps [

	laps > 0 ifFalse: [ 
		Error signal: 'A board must have at least one lap' ]
]

{ #category : #'instance creation' }
SpaceRaceGame class >> with: spaceships boardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps diceCup: aDiceCup and: aDeck [

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
SpaceRaceGame >> allSpaceships [
	^board allSpaceships.
]

{ #category : #actions }
SpaceRaceGame >> board [

	^ board
]

{ #category : #actions }
SpaceRaceGame >> checkIfGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, games has finished' ].
]

{ #category : #actions }
SpaceRaceGame >> checkValidTurn: aSpaceship andCardType: aCard [

	| whoWantsToPlay |
	whoWantsToPlay := self spaceshipOf: aSpaceship.
	whoWantsToPlay checkSpaceshipHas:aCard.

	(turnSequence whoPlays ~= whoWantsToPlay nameOfSpaceship and:
		 aCard isPermanent) ifTrue: [ 
		Error signal:
			'A permanent card cannot be played on another spaceship turn' ].
]

{ #category : #accessing }
SpaceRaceGame >> hasFinished [

	^ self winner notNil 
]

{ #category : #initialize }
SpaceRaceGame >> initializeWith: spaceships aBoardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps aDiceCup: aDiceCup and: aDeck [

	board := Board
		         ships: spaceships
		         with: aBoxSequence
		         distance: aDistance
		         laps: aNumberOfLaps
		         and: aDeck.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: spaceships.
	finished := false.
	lastCardPlayed:= nil.
]

{ #category : #actions }
SpaceRaceGame >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #actions }
SpaceRaceGame >> playATurn [

	| diceResult currentSpaceship effectsOnCurrentSpaceship |
	self checkIfGameIsNotFinished.
	diceResult := diceCup roll.
	currentSpaceship := turnSequence whoPlays.
	effectsOnCurrentSpaceship := (board spaceshipOf: currentSpaceship)
		                        sumOfCardsEffects.
	board move: currentSpaceship with: diceResult + effectsOnCurrentSpaceship.
	turnSequence next
]

{ #category : #action }
SpaceRaceGame >> rankingOf: aShip [


			^ board rankingOf: aShip.
]

{ #category : #action }
SpaceRaceGame >> spaceshipOf: aShip [

	^ board spaceshipOf:aShip.
]

{ #category : #actions }
SpaceRaceGame >> updateLastCardPlayedWith: aLastPlayedCard [

	lastCardPlayed := aLastPlayedCard
]

{ #category : #actions }
SpaceRaceGame >> winner [

	^ board winner
]
