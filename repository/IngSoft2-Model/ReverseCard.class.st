Class {
	#name : #ReverseCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
ReverseCard >> applyUsing: aCardEffectApplicator [ 
	aCardEffectApplicator applyReverseCard.
]

{ #category : #accessing }
ReverseCard >> playedOn: aGame by: aSpaceship [
	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
