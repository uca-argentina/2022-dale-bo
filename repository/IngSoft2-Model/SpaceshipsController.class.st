Class {
	#name : #SpaceshipsController,
	#superclass : #Object,
	#instVars : [
		'positions',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipsController class >> for:ships and:aDeck [
	^self new initializeWith:ships and:aDeck.
	
]

{ #category : #accesing }
SpaceshipsController >> applyAtomicBomb [

	positions do: [ :each | 
		positions replaceAll: each with: (self
				 updateSpaceshipOf: each ownerShip
				 from: each
				 to: 1
				 and: each lapNumber) ]
]

{ #category : #action }
SpaceshipsController >> giveTo: aSpaceship card: aCard [ 
	(self positionOf: aSpaceship) receive: aCard.
]

{ #category : #initialization }
SpaceshipsController >> initializeWith: ships and: aDeck [

	| hand |
	positions := ships collect: [ :ship | 
		             hand := OrderedCollection new.
		             hand add: aDeck giveCard.
		             hand add: aDeck giveCard.
		             Spaceship
			             of: ship
			             at: 1
			             distance: 0
			             laps: 1
			             cards: hand
			             and: OrderedCollection new ].
	winner := nil
]

{ #category : #actions }
SpaceshipsController >> move: aShip to: aNumberOfParsecs finalDistance: endParsecs with: endPosition and: laps [

	| oldPosition shipNewParsecNumber |
	oldPosition := positions detect: [ :each | each ownerShip = aShip ].
	shipNewParsecNumber := oldPosition parsecNumber + (aNumberOfParsecs amountInParsecs).
	positions replaceAll: oldPosition with: (Spaceship
			 of: aShip
			 at: oldPosition boxNumber
			 distance: shipNewParsecNumber % endParsecs
			 laps: oldPosition lapNumber
			 cards: oldPosition hand
			 and: oldPosition effectsOnMe ).
	self
		moveForward: aShip
		to: shipNewParsecNumber // endParsecs
		with: endPosition
		and: laps
]

{ #category : #action }
SpaceshipsController >> moveBackwards: aShip to: aBox with: endPosition and: laps [

	| oldPosition shipNewBoxNumber shipNewLapNumber |
	oldPosition := positions detect: [ :each | each ownerShip = aShip ].
	shipNewBoxNumber := oldPosition boxNumber - aBox.
	shipNewLapNumber := oldPosition lapNumber.
	(shipNewBoxNumber < 1 and: oldPosition lapNumber > 1) ifTrue: [ 
		shipNewBoxNumber := endPosition + shipNewBoxNumber.
		shipNewLapNumber := oldPosition lapNumber - 1 ].
	(shipNewBoxNumber < 1 and: oldPosition lapNumber = 1) ifTrue: [ 
		shipNewBoxNumber := 1 ].

	positions replaceAll: oldPosition with: (self
			 updateSpaceshipOf: aShip
			 from: oldPosition
			 to: shipNewBoxNumber
			 and: shipNewLapNumber)
]

{ #category : #action }
SpaceshipsController >> moveForward: aShip to: aBox with: endPosition and: laps [

	| oldPosition shipNewBoxNumber shipNewLapNumber |
	oldPosition := positions detect: [ :each | each ownerShip = aShip ].
	shipNewBoxNumber := oldPosition boxNumber + aBox.
	(shipNewBoxNumber > endPosition and: oldPosition lapNumber = laps) 
		ifTrue: [ 
			shipNewBoxNumber := endPosition.
			winner := oldPosition ownerShip ].
	(shipNewBoxNumber > endPosition and: oldPosition lapNumber < laps)
		ifTrue: [ 
			shipNewLapNumber := oldPosition lapNumber + 1.
			shipNewBoxNumber := shipNewBoxNumber - endPosition ]
		ifFalse: [ shipNewLapNumber := oldPosition lapNumber ].
	positions replaceAll: oldPosition with: (self
			 updateSpaceshipOf: aShip
			 from: oldPosition
			 to: shipNewBoxNumber
			 and: shipNewLapNumber)
]

{ #category : #accesing }
SpaceshipsController >> positionOf: aShip [
	^ positions detect: [ :each | each ownerShip = aShip ]
]

{ #category : #accesing }
SpaceshipsController >> positions [
	^ positions
]

{ #category : #accesing }
SpaceshipsController >> sortPositionsByRanking [

	positions sort: [ :positionOfShip1 :positionOfShip2 | 
		 positionOfShip1 lapNumber > positionOfShip2 lapNumber  or: [ positionOfShip1 lapNumber = positionOfShip2 lapNumber and: positionOfShip1 boxNumber  > positionOfShip2 boxNumber ]  ]
]

{ #category : #action }
SpaceshipsController >> updateSpaceshipOf: aShip from: oldPosition to: shipNewBoxNumber and: shipNewLapNumber [

	^ Spaceship
		  of: aShip
		  at: shipNewBoxNumber
		  distance: oldPosition parsecNumber
		  laps: shipNewLapNumber
		  cards: oldPosition hand
		  and: oldPosition effectsOnMe
]

{ #category : #accesing }
SpaceshipsController >> winner [
	^winner
]
