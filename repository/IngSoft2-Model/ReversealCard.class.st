Class {
	#name : #ReversealCard,
	#superclass : #PermanentCard,
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
	self applyStrategyFor: aSpaceship in: aGame using: aCardPlay.
]
