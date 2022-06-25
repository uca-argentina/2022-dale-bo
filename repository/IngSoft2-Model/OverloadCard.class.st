Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
OverloadCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [ 
	aCardEffectApplicator applyEffectBasedOn:aCardPlay.
]

{ #category : #action }
OverloadCard >> effect [
	^-2.
]

{ #category : #operations }
OverloadCard >> isPermanent [

	^true.
]

{ #category : #actions }
OverloadCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             itsRedo: itsRedo.

	aGame applyCardPlay: aCardPlay
]

{ #category : #actions }
OverloadCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: aCardEffect.
	(aGame spaceshipOf: anotherSpaceship) isAffectedBy: self.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship).
	(aGame spaceshipOf: aSpaceship) removeFromHand: self
]

{ #category : #actions }
OverloadCard >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	aGame assertValidTurnFor: aSpaceship andCardType: aCardEffect.
	(aGame spaceshipOf: anotherSpaceship) isAffectedBy: self.
	aGame updateLastCardPlayedWith:
		(CardPlay type: self to: anotherSpaceship)
]
