Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> effect [
	^-2.
]

{ #category : #operations }
OverloadCard >> isPermanent [

	^true.
]

{ #category : #actions }
OverloadCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:aCardEffect.
	(aGame positionOfShip:anotherSpaceship) isAffectedBy:self.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
	(aGame positionOfShip:aSpaceship) removeFromHand:self.
]

{ #category : #actions }
OverloadCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:aCardEffect.
	(aGame positionOfShip:anotherSpaceship) isAffectedBy:self.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
]
