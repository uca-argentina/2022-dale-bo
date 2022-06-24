Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RedoCard >> checkIfThereIsACardPlayed: lastPlayedCard [

	lastPlayedCard isNil ifTrue: [ 
		Error signal: 'There is no cards played to apply redo' ]
]

{ #category : #operations }
RedoCard >> isPermanent [

	^false.
]

{ #category : #actions }
RedoCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [
	| aCardPlay |
	aCardPlay:=CardPlay by:aSpaceship type:self to:anotherSpaceship for:(aGame lastCardPlayed).
	aGame redoCardPlay:aCardPlay.
]

{ #category : #actions }
RedoCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastPlayedCard |
	lastPlayedCard := aGame lastCardPlayed.
	self checkIfThereIsACardPlayed: lastPlayedCard.
	aGame assertValidTurnFor: aSpaceship andCardType: self.
	(aGame spaceshipOf: aSpaceship) removeFromHand: self.
	lastPlayedCard card
		redoUsing: aGame
		by: aSpaceship
		to: anotherSpaceship
		for: lastPlayedCard card
]

{ #category : #actions }
RedoCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastPlayedCard |
	lastPlayedCard := aGame lastCardPlayed.
	aGame assertValidTurnFor: aSpaceship andCardType: self.
	lastPlayedCard card
		redoUsing: aGame
		by: aSpaceship
		to: anotherSpaceship
		for: lastPlayedCard card
]
