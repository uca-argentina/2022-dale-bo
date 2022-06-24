Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'lastCancelledEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> checkIfThereIsACardPlayedIn: aGame [

	aGame lastCardPlayed isNil ifTrue: [ 
		Error signal: 'There is no cards played to be canceled' ]
]

{ #category : #operations }
CancellationCard >> isPermanent [

	^false.
]

{ #category : #actions }
CancellationCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship for: aCard [ 
	| aCardPlay |
	aCardPlay:=CardPlay by:aSpaceship type:self to:anotherSpaceship for:aCard.
	aGame cancelCardPlay:aCardPlay.
]

{ #category : #actions }
CancellationCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	lastCancelledEffect := aCardEffect.
	self checkIfThereIsACardPlayedIn: aGame.
	aGame assertValidTurnFor: aSpaceship andCardType: self.
	(aGame spaceshipOf: anotherSpaceship) removeEffect: aCardEffect.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship).
	(aGame spaceshipOf: aSpaceship) removeFromHand: self
]

{ #category : #actions }
CancellationCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: self.
	(aGame spaceshipOf: anotherSpaceship) removeEffect:
		lastCancelledEffect.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship)
]
