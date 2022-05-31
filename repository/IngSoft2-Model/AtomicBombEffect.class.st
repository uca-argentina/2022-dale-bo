Class {
	#name : #AtomicBombEffect,
	#superclass : #BoxEffect,
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
AtomicBombEffect >> applyTo: ships triggeredBy: aShip with: endPosition and:laps [
 	ships applyAtomicBomb
]

{ #category : #initialization }
AtomicBombEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
