Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
CancellationCard >> applyTo: target over:aCardEffect [.

	target removeEffect:aCardEffect.
]

{ #category : #operations }
CancellationCard >> isPermanent [

	^false.
]

{ #category : #actions }
CancellationCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:self.
	(aGame positionOfShip:anotherSpaceship) removeEffect:aCardEffect.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
]
