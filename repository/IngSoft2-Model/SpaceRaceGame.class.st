Class {
	#name : #SpaceRaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'turnSequence',
		'deck',
		'boxEffectApplicator',
		'allSpaceshipsHands',
		'lastCardPlay',
		'lastBoxEffect',
		'spaceshipsInPrison'
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

	distance negative ifTrue: [ 
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

{ #category : #accessing }
SpaceRaceGame >> allSpaceshipsHands [
	^allSpaceshipsHands.
]

{ #category : #actions }
SpaceRaceGame >> applyCardPlayFor:aCardPlay [
	 ^ (CardEffectApplicator with:aCardPlay using:self) execute
]

{ #category : #actions }
SpaceRaceGame >> assertGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, game has finished' ].
]

{ #category : #actions }
SpaceRaceGame >> board [

	^board.
]

{ #category : #actions }
SpaceRaceGame >> calculateNewBoxNumberWith: aDiceResult [

	| whoPlays effectsOnCurrentSpaceship |
	whoPlays := turnSequence whoPlays.
	effectsOnCurrentSpaceship := (self handOf: whoPlays)
		                             sumOfCardsEffects.
	(spaceshipsInPrison includes: whoPlays)
		ifTrue: [ self checkSpaceshipCanLeaveJailWith: aDiceResult ]
		ifFalse: [
			board move: whoPlays to: aDiceResult + effectsOnCurrentSpaceship.
			lastBoxEffect:= board effectAt:(turnSequence whoPlays).
			boxEffectApplicator
				applyTo: (board positionOf: whoPlays)
				using: self ]
]

{ #category : #private }
SpaceRaceGame >> checkIfPrisonIsOccupiedBy: aSpaceship [
	^ spaceshipsInPrison
		  detect: [ :each | each = aSpaceship]
		  ifNone: [ Error signal: 'You cant free a spaceship thats not in prison' ]
]

{ #category : #actions }
SpaceRaceGame >> checkSpaceshipCanLeaveJailWith: aDiceResult [
	(aDiceResult = diceCup maxToss) ifTrue:[self freeFromJail:turnSequence whoPlays].
]

{ #category : #actions }
SpaceRaceGame >> createHandFor: aCollectionOfShips [

	| hand cards |
	allSpaceshipsHands := aCollectionOfShips collect: [ :ship | 
		              cards := OrderedCollection new.
		              cards add: deck giveCard.
		              cards add: deck giveCard.
		              hand := SpaceshipHand with: cards for:ship.]
]

{ #category : #action }
SpaceRaceGame >> distanceInBoxOf: aSpaceship [

	^ (board positionOf:aSpaceship) distanceInBox.
]

{ #category : #actions }
SpaceRaceGame >> freeFromJail: aSpaceship [
	self checkIfPrisonIsOccupiedBy:aSpaceship.
	spaceshipsInPrison remove:aSpaceship. 
]

{ #category : #actions }
SpaceRaceGame >> giveTo: aSpaceship card: aCard [

	| aSpaceshipHand |
	aSpaceshipHand:= self handOf: aSpaceship.
	aSpaceshipHand recieveCard:aCard.
]

{ #category : #action }
SpaceRaceGame >> handOf: aSpaceship [

	^ allSpaceshipsHands detect: [:each | (each name) = aSpaceship].
]

{ #category : #accessing }
SpaceRaceGame >> hasFinished [
	^ board thereIsAWinner.
]

{ #category : #initialize }
SpaceRaceGame >> initializeWith: spaceships aBoardWith: aBoxSequence distance: aDistance laps: aNumberOfLaps aDiceCup: aDiceCup and: aDeck [
	deck:= aDeck.
	boxEffectApplicator:=BoxEffectsApplicator new.
	self createHandFor:spaceships.
	board := Board
		         ships: spaceships
		         with: aBoxSequence
		         distance: aDistance
		         laps: aNumberOfLaps.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: spaceships.
	lastBoxEffect := InvalidEffect new.
	lastCardPlay:= InvalidCard new.
	spaceshipsInPrison:= OrderedCollection new.
]

{ #category : #accessing }
SpaceRaceGame >> lastBoxEffect [
	^ lastBoxEffect
]

{ #category : #actions }
SpaceRaceGame >> lastCardPlayed [

	^lastCardPlay.
]

{ #category : #actions }
SpaceRaceGame >> playATurn [

	| diceResult|
	self assertGameIsNotFinished.
	diceResult := diceCup roll.
	self calculateNewBoxNumberWith: diceResult.
	board sortPositionsByRanking.
	turnSequence next
]

{ #category : #action }
SpaceRaceGame >> positionOf: aSpaceship [

	^ board positionOf:aSpaceship.
]

{ #category : #action }
SpaceRaceGame >> rankingOf: aShip [


			^ board rankingOf: aShip.
]

{ #category : #actions }
SpaceRaceGame >> sendToJail: aSpaceship [ 
	spaceshipsInPrison add:aSpaceship. 
]

{ #category : #accessing }
SpaceRaceGame >> spaceshipsInPrison [
	^ spaceshipsInPrison
]

{ #category : #actions }
SpaceRaceGame >> turnSequence [

	^turnSequence .
]

{ #category : #actions }
SpaceRaceGame >> updateLastCardPlayed:aCard [
	lastCardPlay := aCard.
]

{ #category : #actions }
SpaceRaceGame >> winner [

	^board winner.
]
