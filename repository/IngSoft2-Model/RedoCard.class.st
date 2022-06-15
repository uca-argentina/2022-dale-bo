Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
RedoCard >> applyTo: target over:aCardEffect [

	target isAffectedBy: self..
]

{ #category : #operations }
RedoCard >> isPermanent [

	^false.
]

{ #category : #actions }
RedoCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	| lastPlayedCard |
	lastPlayedCard := aGame lastCardPlayed.
	aGame checkValidTurn: aSpaceship andCardType: lastPlayedCard card.
	(aGame positionOfShip: lastPlayedCard affectedSpaceship) 
		isAffectedBy: lastPlayedCard card
]
