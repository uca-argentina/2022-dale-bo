Class {
	#name : #ReversealCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

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
