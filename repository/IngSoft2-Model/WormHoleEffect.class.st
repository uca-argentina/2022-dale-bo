Class {
	#name : #WormHoleEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> changePolarity [
	^ WormHoleReversedEffect new.
]

{ #category : #action }
WormHoleEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: -4
]
