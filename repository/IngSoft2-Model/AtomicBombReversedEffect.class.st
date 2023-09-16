Class {
	#name : #AtomicBombReversedEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBombReversedEffect >> changePolarity [
	^ AtomicBombEffect new.
]

{ #category : #actions }
AtomicBombReversedEffect >> triggeredBy: aSpaceship with: aGame [
	(aGame board) calculate: aSpaceship newpositionUsing: 0
]
