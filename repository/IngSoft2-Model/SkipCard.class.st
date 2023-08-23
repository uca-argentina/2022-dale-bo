Class {
	#name : #SkipCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SkipCard >> applyUsing: aCardEffectApplicator [ 
	aCardEffectApplicator applySkipCard.
]

{ #category : #actions }
SkipCard >> playedOn: aGame by: aSpaceship [
	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
