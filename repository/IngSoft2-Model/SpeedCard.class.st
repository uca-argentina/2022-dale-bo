Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpeedCard >> applyTo: target over:aCardEffect [

	target isAffectedBy: self.
]

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
	aGame checkValidTurn:aSpaceship andCardType:aCardEffect.
	(aGame positionOfShip:anotherSpaceship) isAffectedBy:self.
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
]
