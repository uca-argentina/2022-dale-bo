Class {
	#name : #FreedomCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
FreedomCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyFreedomCard.
]

{ #category : #actions }
FreedomCard >> playedOn: aGame by: aSpaceship [
	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
