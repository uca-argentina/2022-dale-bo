Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accesing }
SpeedCard >> effect [
	^ 1.
]

{ #category : #operations }
SpeedCard >> isPermanent [

	^true.
]

{ #category : #actions }
SpeedCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:self.
	(aGame positionOfShip:anotherSpaceship) isAffectedBy:self.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
	(aGame positionOfShip:aSpaceship) removeFromHand:self.
]

{ #category : #actions }
SpeedCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:self.
	(aGame positionOfShip:anotherSpaceship) isAffectedBy:self.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
]
