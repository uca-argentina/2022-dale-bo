Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accesing }
SpeedCard >> effect [

	^ 1
]

{ #category : #operations }
SpeedCard >> isPermanent [

	^true.
]

{ #category : #actions }
SpeedCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             type: self
		             to: anotherSpaceship for:nil.
	aGame applyCardPlay: aCardPlay
]

{ #category : #actions }
SpeedCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: self.
	(aGame spaceshipOf: anotherSpaceship) isAffectedBy: self.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship).
	(aGame spaceshipOf: aSpaceship) removeFromHand: self
]

{ #category : #actions }
SpeedCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: self.
	(aGame spaceshipOf: anotherSpaceship) isAffectedBy: self.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship)
]
