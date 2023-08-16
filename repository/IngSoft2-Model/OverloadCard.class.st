Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
OverloadCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyOverloadCard.
]

{ #category : #action }
OverloadCard >> effect [
	^-2.
]

{ #category : #actions }
OverloadCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             needsRemove: false.

	aGame applyCardPlayFor: aCardPlay
]
