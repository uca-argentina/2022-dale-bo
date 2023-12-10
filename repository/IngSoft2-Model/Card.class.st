Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> applyUsing: aCardEffectApplicator [ 
	aCardEffectApplicator applyReversealCard.
]
