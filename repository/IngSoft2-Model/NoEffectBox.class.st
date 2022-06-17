Class {
	#name : #NoEffectBox,
	#superclass : #BoxEffect,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
NoEffectBox class >> distance: aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
NoEffectBox >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [

	spaceships
		moveForward: aSpaceship
		to: 0
		with: endPosition
		and: laps
]

{ #category : #initialization }
NoEffectBox >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
