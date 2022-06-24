Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> effect [

	^ 1
]

{ #category : #operations }
AccelerationCard >> isPermanent [

	^true.
]

{ #category : #actions }
AccelerationCard >> playedOn: aGame by: aSpaceship [
	
	| aCardPlay |
	aCardPlay:=CardPlay by:aSpaceship type:self to:'all'.
	aGame applyCardPlay:aCardPlay.
]

{ #category : #actions }
AccelerationCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: aCardEffect.
	aGame allSpaceships do: [ :each | each isAffectedBy: aCardEffect ].
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship).
	(aGame spaceshipOf: aSpaceship) removeFromHand: self
]

{ #category : #actions }
AccelerationCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: aCardEffect.
	aGame allSpaceships do: [ :each | each isAffectedBy: aCardEffect ].
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship)
]
