Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'finished',
		'turnSequence',
		'positionController',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance colors' }
Game class >> assertCollectionOfShipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']
]

{ #category : #'instance colors' }
Game class >> assertValidDistance: distance [
	(distance amount ) < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
]

{ #category : #'instance colors' }
Game class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #'instance creation' }
Game class >> spaceships: ships boardWith: aBoxSequence distance: distance laps: laps diceCup: aDiceCup and: aDeck [

	self assertCollectionOfShipsIsValid: ships.
	self assertValidLaps: laps.
	self assertValidDistance: distance.
	^ self new
		  initializeWith: ships
		  aBoardWith: aBoxSequence
		  distance: distance
		  laps: laps
		  aDiceCup: aDiceCup
		  and: aDeck
]

{ #category : #accessing }
Game >> allShips [
	^board allShips.
]

{ #category : #actions }
Game >> checkIfGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, games has finished' ].
]

{ #category : #actions }
Game >> checkValidTurn: aSpaceship andCardType: aCard [

	| whoWantsToPlay |
	whoWantsToPlay := self positionOfShip: aSpaceship.
	whoWantsToPlay checkSpaceshipHas:aCard.

	(turnSequence whoPlays ~= whoWantsToPlay ownerShip and:
		 aCard isPermanent) ifTrue: [ 
		Error signal:
			'A permanent card cannot be played on another spaceship turn' ].
]

{ #category : #accessing }
Game >> hasFinished [

	^ self winner ~= nil
]

{ #category : #initialize }
Game >> initializeWith: spaceships aBoardWith: aBoxSequence distance: aDistance laps: laps aDiceCup: aDiceCup and: aDeck [

	board := Board
		         ships: spaceships
		         with: aBoxSequence
		         distance: aDistance
		         laps: laps
		         and: aDeck.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: spaceships.
	finished := false.
	lastCardPlayed:= nil.
]

{ #category : #actions }
Game >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #actions }
Game >> lastCardPlayed: aLastPlayedCard [ 
	lastCardPlayed := aLastPlayedCard
]

{ #category : #actions }
Game >> playATurn [
   | diceResult currentSpaceship effectsOnCurrentShip|
	self checkIfGameIsNotFinished.
	diceResult := diceCup roll.
	currentSpaceship := turnSequence whoPlays.
	effectsOnCurrentShip := (board positionOf: currentSpaceship) sumOfCardsEffects .
	board play: (currentSpaceship)  with: (diceResult + effectsOnCurrentShip ).
	turnSequence next.
]

{ #category : #actions }
Game >> playRepeatCardBy: aSpaceship to: anotherSpaceship [
	| lastBoxEffect |
	lastBoxEffect:=board lastBoxEffect.
   self checkValidTurn: aSpaceship andCardType: RepeatCard new.
	(self positionOfShip: aSpaceship)
		playACard: RepeatCard new
		to: (self positionOfShip: anotherSpaceship)
		on: ''.
	
   lastBoxEffect applyTo: (board spaceshipController)  triggeredBy:  anotherSpaceship  with: board lastPosition  distance: board boxesDistance laps: board laps.
	lastCardPlayed := LastPlayedCard type:(SpeedCard new) to:anotherSpaceship.
]

{ #category : #action }
Game >> positionOfShip: aShip [

	^ board positionOf:aShip.
]

{ #category : #action }
Game >> rankingOf: aShip [


			^ board rankingOf: aShip.
]

{ #category : #actions }
Game >> winner [

	^ board winner
]
