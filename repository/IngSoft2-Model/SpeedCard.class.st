Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applySpeedCard.
]

{ #category : #actions }
SpeedCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [ 
	aCardEffectApplicator applySpeedCard.
]

{ #category : #accesing }
SpeedCard >> effect [

	^ 1
]

{ #category : #operations }
SpeedCard >> isPermanent [

	^true.
]

{ #category : #actions }
SpeedCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
