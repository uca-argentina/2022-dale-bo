Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHoleEffect class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
WormHoleEffect >> effect [

	^ -4
]

{ #category : #action }
WormHoleEffect >> effectTo: ships appliedBy: aShip with: endPosition and: laps [

	ships
		moveBackwards: aShip
		to: self effect
		with: endPosition
		and: laps
]

{ #category : #action }
WormHoleEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
