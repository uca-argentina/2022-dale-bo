Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
RedoCard >> isPermanent [

	^false.
]

{ #category : #actions }
RedoCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastPlayedCard |
	lastPlayedCard := aGame lastCardPlayed.
	( lastPlayedCard  isNil) ifTrue: [ 
		Error signal:
			'There is no cards played to apply redo' ].
	aGame checkValidTurn: aSpaceship andCardType: self.
	(aGame positionOfShip: aSpaceship) removeFromHand: self.
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
	aGame checkValidTurn: aSpaceship andCardType: self.
	lastPlayedCard card
		redoUsing: aGame
		by: aSpaceship
		to: anotherSpaceship
		for: lastPlayedCard card
]
