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
CancellationCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	lastCancelledEffect := aCardEffect.
	self checkIfThereIsACardPlayedIn: aGame.
	aGame checkValidTurn: aSpaceship andCardType: self.
	(aGame spaceshipOf: anotherSpaceship) removeEffect: aCardEffect.
	aGame updateLastCardPlayedWith:
		(LastPlayedCard type: self to: anotherSpaceship).
	(aGame spaceshipOf: aSpaceship) removeFromHand: self
]

{ #category : #actions }
CancellationCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame checkValidTurn: aSpaceship andCardType: self.
	(aGame spaceshipOf: anotherSpaceship) removeEffect:
		lastCancelledEffect.
	aGame updateLastCardPlayedWith:
		(LastPlayedCard type: self to: anotherSpaceship)
]
