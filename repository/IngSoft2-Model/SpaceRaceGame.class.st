Class {
	#name : #SpaceRaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'finished',
		'turnSequence',
		'lastCardPlayed',
		'cardEffectApplier'
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
SpaceRaceGame >> applyCardPlay: aCardPlay [
	
	
	cardEffectApplier apply:aCardPlay
]

{ #category : #actions }
SpaceRaceGame >> assertGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, game has finished' ].
]

{ #category : #asserting }
SpaceRaceGame >> assertThereIsACardPlayed [
	lastCardPlayed ifNil: [ 
		Error signal: 'There is no cards played to be canceled' ]
]

{ #category : #actions }
SpaceRaceGame >> assertValidTurnFor: aSpaceship andCardType: aCard [

	| whoWantsToPlay |
	whoWantsToPlay := self spaceshipOf: aSpaceship.
	(whoWantsToPlay hand) checkSpaceshipHas:aCard.

	(turnSequence whoPlays ~= whoWantsToPlay nameOfSpaceship and:
		 aCard isPermanent) ifTrue: [ 
		Error signal:
			'A permanent card cannot be played on another spaceship turn' ].
]

{ #category : #actions }
SpaceRaceGame >> board [

	^ board
]

{ #category : #actions }
SpaceRaceGame >> cancelCardPlay: aCardPlay [ 
	self assertValidTurnFor: (aCardPlay) playedBy andCardType: aCardPlay cardType.
	self assertThereIsACardPlayed.
	cardEffectApplier cancel: aCardPlay using: board.
	lastCardPlayed:=aCardPlay.
	
]

{ #category : #accessing }
SpaceRaceGame >> hasFinished [

	^ board winner notNil
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
	cardEffectApplier:= CardEffectApplicator with:board.
]

{ #category : #actions }
SpaceRaceGame >> lastCardPlayed [

	^ cardEffectApplier lastCardPlayed.
]

{ #category : #actions }
SpaceRaceGame >> playATurn [

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
SpaceRaceGame >> rankingOf: aShip [


			^ board rankingOf: aShip.
]

{ #category : #actions }
SpaceRaceGame >> redoCardPlay: aCardPlay [ 
	self assertValidTurnFor: (aCardPlay) playedBy andCardType: (aCardPlay targetedCard) cardType.
	cardEffectApplier redo: aCardPlay using: board.
]

{ #category : #actions }
SpaceRaceGame >> repeatCardPlay: aCardPlay [ 
	self assertValidTurnFor: (aCardPlay) playedBy andCardType: aCardPlay cardType.
	cardEffectApplier repeat: aCardPlay using: board.
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

	board winner
		ifNil: [ 
			Error signal:
				'Game does not have a winner beacause is not finished yet' ]
		ifNotNil: [ ^ board winner ]
]
