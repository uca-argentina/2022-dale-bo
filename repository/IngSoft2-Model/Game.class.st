Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'finished',
		'turnSequence',
		'positionController'
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
	distance < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
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

{ #category : #actions }
Game >> checkIfGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, games has finished' ].
]

{ #category : #actions }
Game >> checkValidTurn: aSpaceship andCardType: aCard [

	| whoWantsToPlay |
	whoWantsToPlay := self positionOfShip: aSpaceship.

	(turnSequence whoPlays ~= whoWantsToPlay ownerShip and:
		 aCard family = 'Permanent') ifTrue: [ 
		Error signal:
			'A permanent card cannot be played on another spaceship turn' ].
]

{ #category : #accessing }
Game >> hasFinished [

	^ self winner ~= 'No one'
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
	finished := false
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
Game >> playAccelerationCardBy: aSpaceship [
self checkValidTurn: aSpaceship andCardType: (AccelerationCard new).
	(self positionOfShip:aSpaceship) playACard:(AccelerationCard new) to: (board allShips)
]

{ #category : #actions }
Game >> playOverloadCardBy: aSpaceship to: anotherShip [

	self checkValidTurn: aSpaceship andCardType: OverloadCard new.
	(self positionOfShip: aSpaceship)
		playACard:  OverloadCard new
		to: anotherShip.
]

{ #category : #actions }
Game >> playSpeedCardBy: aSpaceship to: anotherShip [

	self checkValidTurn: aSpaceship andCardType: SpeedCard new.
	(self positionOfShip: aSpaceship)
		playACard: SpeedCard new
		to: anotherShip.
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
