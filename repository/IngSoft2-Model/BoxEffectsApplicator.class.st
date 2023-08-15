Class {
	#name : #BoxEffectsApplicator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoxEffectsApplicator >> applyTo: aSpaceshipPosition using:aGame [

	(aGame lastBoxEffect) triggeredBy:aSpaceshipPosition name with: aGame.
]
