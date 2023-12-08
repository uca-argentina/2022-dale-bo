Class {
	#name : #ReversealCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
ReversealCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyReversealCard.
]

{ #category : #operations }
ReversealCard >> effect [
	^ 2
]

{ #category : #actions }
ReversealCard >> playedOn: aGame by: aSpaceship onBox: aPosition [
	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aPosition 
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
