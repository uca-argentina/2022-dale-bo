Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
RepeatCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyRepeatCard.
]

{ #category : #actions }
RepeatCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [

	aCardEffectApplicator applyRepeatBasedOn: aCardPlay
]

{ #category : #operations }
RepeatCard >> isPermanent [

	^false.
]

{ #category : #actions }
RepeatCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
