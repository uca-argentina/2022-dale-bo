Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
RepeatCard >> isPermanent [

	^false.
]

{ #category : #actions }
RepeatCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastBoxEffect board |
	board := aGame board.
	lastBoxEffect := board lastBoxEffect.
	aGame checkValidTurn: aSpaceship andCardType: self.
	lastBoxEffect
		applyTo: board spaceshipController
		triggeredBy: anotherSpaceship
		with: board lastPosition
		distance: board boxesDistance
		laps: board laps.
	aGame lastCardPlayed:
		(LastPlayedCard type: self to: anotherSpaceship).
	(aGame positionOfShip: aSpaceship) removeFromHand: self
]

{ #category : #actions }
RepeatCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastBoxEffect board |
	board := aGame board.
	lastBoxEffect := board lastBoxEffect.
	aGame checkValidTurn: aSpaceship andCardType: self.
	lastBoxEffect
		applyTo: board spaceshipController
		triggeredBy: anotherSpaceship
		with: board lastPosition
		distance: board boxesDistance
		laps: board laps.
	aGame lastCardPlayed:
		(LastPlayedCard type: self to: anotherSpaceship).
]
