Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AccelerationCard >> applyTo: target over:aCardEffect [

	target do:[:each | each isAffectedBy: self].
]

{ #category : #action }
AccelerationCard >> effect [

	^ 1
]

{ #category : #operations }
AccelerationCard >> isPermanent [

	^true.
]

{ #category : #actions }
AccelerationCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	aGame checkValidTurn:aSpaceship andCardType:aCardEffect.
	(aGame allShips ) do:[:each| (each) isAffectedBy: aCardEffect].
	aGame lastCardPlayed:(LastPlayedCard type:self to:anotherSpaceship).
]
