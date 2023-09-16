Class {
	#name : #WormHoleReversedEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleReversedEffect >> changePolarity [
	^ WormHoleEffect new.
]

{ #category : #actions }
WormHoleReversedEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board)
		moveBackwards: -4
		allSpaceshipsExcept: aSpaceship
]
