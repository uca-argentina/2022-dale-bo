Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyCancellationCard.
]

{ #category : #actions }
CancellationCard >> playedOn: aGame by: aSpaceship to: aCard [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: aCard
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
