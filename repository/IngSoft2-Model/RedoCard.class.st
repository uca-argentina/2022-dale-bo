Class {
	#name : #RedoCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RedoCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyRedoCard.
]

{ #category : #actions }
RedoCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             needsRemove: false.
	(aGame lastCardPlayed) applyStrategyFor: aSpaceship in: aGame using: aCardPlay.
	"self applyStrategyFor: aSpaceship in: aGame using: aCardPlay."
]
