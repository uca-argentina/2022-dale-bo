Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AccelerationCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyAccelerationCard.
]

{ #category : #operations }
AccelerationCard >> effect [

	^ 1
]

{ #category : #actions }
AccelerationCard >> playedOn: aGame by: aSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aGame allSpaceshipsHands
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
