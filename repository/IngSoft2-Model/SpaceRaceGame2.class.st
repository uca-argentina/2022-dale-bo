Class {
	#name : #SpaceRaceGame2,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'turnSequence',
		'cardEffectApplier',
		'deck',
		'boxEffectApplicator',
		'allSpaceshipsHands',
		'lastCardPlay'
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

{ #category : #accessing }
SpaceRaceGame2 >> allSpaceshipsHands [
	^allSpaceshipsHands.
]

{ #category : #actions }
SpaceRaceGame2 >> applyCardPlayFor:aCardPlay [
	 ^ (CardEffectApplicator2 with:aCardPlay using:self) execute
]

{ #category : #actions }
SpaceRaceGame2 >> assertGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, game has finished' ].
]

{ #category : #actions }
SpaceRaceGame2 >> board [

	^board.
]

{ #category : #actions }
SpaceRaceGame2 >> createHandFor: aCollectionOfShips [

	| hand cards |
	allSpaceshipsHands := aCollectionOfShips collect: [ :ship | 
		              cards := OrderedCollection new.
		              cards add: deck giveCard.
		              cards add: deck giveCard.
		              hand := SpaceshipHand with: cards for:ship.]
]

{ #category : #action }
SpaceRaceGame2 >> distanceInBoxOf: aSpaceship [

	^ (board spaceshipOf:aSpaceship) position distanceInBox.
]

{ #category : #actions }
SpaceRaceGame2 >> giveTo: aSpaceship card: aCard [

	| aSpaceshipHand |
	aSpaceshipHand:= self handOf: aSpaceship.
	aSpaceshipHand recieveCard:aCard.
]

{ #category : #action }
SpaceRaceGame2 >> handOf: aSpaceship [

	^ allSpaceshipsHands detect: [:each | (each name) = aSpaceship].
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
	lastCardPlay:= InvalidCardPlay new.
]

{ #category : #actions }
SpaceRaceGame2 >> playATurn [

	| diceResult whoPlays effectsOnCurrentSpaceship |
	self assertGameIsNotFinished.
	diceResult := diceCup roll.
	whoPlays:=turnSequence whoPlays.
	"effectsOnCurrentSpaceship := (board spaceshipOf: currentSpaceship)
		                        effectsOnSpaceship sumOfCardsEffects."
	effectsOnCurrentSpaceship:= (self handOf:whoPlays) sumOfCardsEffects.
	board move: turnSequence whoPlays to: diceResult+effectsOnCurrentSpaceship.
	boxEffectApplicator applyTo:(board positionOf:whoPlays) using:self.
	board sortPositionsByRanking.
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
SpaceRaceGame2 >> turnSequence [

	^turnSequence .
]

{ #category : #actions }
SpaceRaceGame2 >> updateLastCardPlayed:aCard [
	lastCardPlay := aCard.
]

{ #category : #actions }
SpaceRaceGame2 >> winner [

	^board winner.
]
