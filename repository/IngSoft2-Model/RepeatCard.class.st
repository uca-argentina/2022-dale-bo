Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [

	aCardEffectApplicator applyRepeatBasedOn: aCardPlay
]

{ #category : #operations }
RepeatCard >> isPermanent [

	^false.
]

{ #category : #actions }
RepeatCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             itsRedo: false.
	aGame applyCardPlay: aCardPlay
]

{ #category : #actions }
RepeatCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastBoxEffect board |
	board := aGame board.
	lastBoxEffect := board lastBoxEffect.
	aGame assertValidTurnFor: aSpaceship andCardType: self.
	lastBoxEffect
		applyTo: board spaceshipController
		triggeredBy: anotherSpaceship
		with: board sizeOfBoard
		distance: board distancePerBox
		laps: board laps.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship).
	(aGame spaceshipOf: aSpaceship) removeFromHand: self
]

{ #category : #actions }
RepeatCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastBoxEffect board |
	board := aGame board.
	lastBoxEffect := board lastBoxEffect.
	aGame assertValidTurnFor: aSpaceship andCardType: self.
	lastBoxEffect
		applyTo: board spaceshipController
		triggeredBy: anotherSpaceship
		with: board sizeOfBoard
		distance: board distancePerBox
		laps: board laps.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship)
]
