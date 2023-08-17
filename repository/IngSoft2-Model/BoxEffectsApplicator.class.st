Class {
	#name : #BoxEffectsApplicator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'action handling' }
BoxEffectsApplicator >> applyTo: aSpaceshipPosition using:aGame [

	(aGame lastBoxEffect) triggeredBy:aSpaceshipPosition name with: aGame.
]
