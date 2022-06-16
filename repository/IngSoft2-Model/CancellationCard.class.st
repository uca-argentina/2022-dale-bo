Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'lastCancelledEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
CancellationCard >> isPermanent [

	^false.
]

{ #category : #actions }
CancellationCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	lastCancelledEffect := aCardEffect.
	aGame lastCardPlayed isNil ifTrue: [ 
		Error signal: 'There is no cards played to be canceled' ].
	aGame checkValidTurn: aSpaceship andCardType: self.
	(aGame positionOfShip: anotherSpaceship) removeEffect: aCardEffect.

	aGame lastCardPlayed:
		(LastPlayedCard type: self to: anotherSpaceship).
	(aGame positionOfShip: aSpaceship) removeFromHand: self
]

{ #category : #actions }
CancellationCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:self.
	(aGame positionOfShip:anotherSpaceship) removeEffect:lastCancelledEffect.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
]
