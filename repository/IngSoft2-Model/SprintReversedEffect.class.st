Class {
	#name : #SprintReversedEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SprintReversedEffect >> changePolarity [
	^ SprintEffect new.
]

{ #category : #action }
SprintReversedEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculateNewPositionsExceptFor: aSpaceship newpositionUsingHands: (aGame allSpaceshipsHands)
]
