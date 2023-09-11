Class {
	#name : #ReversePolarityCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
ReversePolarityCard class >> playedOn: aGame by: aSpaceship to: aBoxNumber [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aBoxNumber
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]

{ #category : #actions }
ReversePolarityCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyReversePolarityCard.
]

{ #category : #actions }
ReversePolarityCard >> playedOn: aGame by: aSpaceship to: aBoxNumber [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aBoxNumber
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
