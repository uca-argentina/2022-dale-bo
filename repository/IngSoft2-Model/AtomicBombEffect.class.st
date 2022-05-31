Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
AtomicBombEffect class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs .
]

{ #category : #action }
AtomicBombEffect >> effectTo: ships appliedBy: aShip with: endPosition and: laps [

	ships applyAtomicBomb
]

{ #category : #initialization }
AtomicBombEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
