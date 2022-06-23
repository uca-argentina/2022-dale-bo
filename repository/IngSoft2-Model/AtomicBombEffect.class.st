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
AtomicBombEffect >> applyTo: spaceships triggeredBy: aSpaceship with: aBoard [

	spaceships applyAtomicBomb
]

{ #category : #action }
AtomicBombEffect >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [

	spaceships applyAtomicBomb
]

{ #category : #initialization }
AtomicBombEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
