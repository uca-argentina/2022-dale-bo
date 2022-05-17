Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
AtomicBomb class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs .
]

{ #category : #action }
AtomicBomb >> effectTo: ships appliedBy: aShip with: endPosition and: laps [

	ships applyAtomicBomb
]

{ #category : #initialization }
AtomicBomb >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
