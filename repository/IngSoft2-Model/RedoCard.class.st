Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RedoCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applyRedoCard.
]

{ #category : #actions }
RedoCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [ 
	aCardEffectApplicator applyRedoBasedOn:aCardPlay.
]

{ #category : #operations }
RedoCard >> isPermanent [

	^false.
]

{ #category : #actions }
RedoCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             needsRemove: false.
	aGame applyCardPlayFor: aCardPlay
]
