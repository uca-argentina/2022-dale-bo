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

{ #category : #'class initialization' }
Game class >> ships: ships boardWithNoEffectsOf: numberOfBoxes distance: distance laps: laps and: aDiceCup [ 
	self assertCollectionOfShipsIsValid:ships.
	^ self new initializeWith: ships aBoardWithNoEffectsOf: numberOfBoxes distance: distance laps: laps and: aDiceCup.
]

{ #category : #'instance creation' }
Game class >> ships: ships boardWithOnly: anEffect at: aNumberOfBox of: numberOfBoxes distance: distance laps: laps and: aDiceCup [ 
	self assertCollectionOfShipsIsValid:ships.
	^ self new initializeWith: ships aBoardWithOnly: anEffect at: aNumberOfBox of: numberOfBoxes distance: distance laps: laps and: aDiceCup.
]

{ #category : #'instance colors' }
Game class >> with: ships a: aBoard and: aDiceCup [
	self assertCollectionOfShipsIsValid:ships.
	^ self new initializeWith: ships a: aBoard and: aDiceCup
]

{ #category : #actions }
Game >> checkIfGameIsNotFinished [

	(self hasFinished) ifTrue: [Error signal: 'Turn cannot be played, games has finished' ].
]

{ #category : #accessing }
Game >> hasFinished [

	^ self winner ~= 'No one'
]

{ #category : #initializing }
Game >> initializeWith: aShips a: aBoard and: aDiceCup [

	positionController := PositionController for: aShips.
	board := aBoard.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: aShips.
	finished := false.
]

{ #category : #initialization }
Game >> initializeWith: ships aBoardWithNoEffectsOf: aNumberOfBoxes distance: aDistance laps: laps and: aDiceCup [

	board := Board
		         players: ships
		         withNoEffectsOf: aNumberOfBoxes
		         distance: aDistance
		         laps: laps.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: ships.
	finished := false
]

{ #category : #initialize }
Game >> initializeWith: ships aBoardWithOnly: anEffect at: aNumberOfBox of: numberOfBoxes distance: aDistance laps: laps and: aDiceCup [ 
	board := Board
		         players: ships
		         withOnly: anEffect
					at: aNumberOfBox 
					of: numberOfBoxes
		         distance: aDistance
		         laps: laps.
	diceCup := aDiceCup.
	turnSequence := TurnSequence with: ships.
	finished := false
]

{ #category : #actions }
Game >> playATurn [
   | diceResult currentPlayer cardEffect|
	self checkIfGameIsNotFinished.
	diceResult := diceCup roll.
	currentPlayer := turnSequence next.
	cardEffect := (board positionOf: currentPlayer) effects .
	board play: (currentPlayer)  with: (diceResult + cardEffect).
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
