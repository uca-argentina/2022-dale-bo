Class {
	#name : #DoubleCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DoubleCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyDoubleCard.
]

{ #category : #actions }
DoubleCard >> playedOn: aGame by: aSpaceship [
	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
