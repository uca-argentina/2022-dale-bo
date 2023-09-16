Class {
	#name : #AtomicBombEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBombEffect >> changePolarity [
	^ AtomicBombReversedEffect new.
]

{ #category : #action }
AtomicBombEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) moveSpaceshipsToTheFirstBox
	
]
