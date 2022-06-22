Class {
	#name : #NoEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
NoEffect class >> distance: aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
NoEffect >> applyTo: spaceships triggeredBy: aSpaceship with: aBoard [

	aBoard
		moveForward: aSpaceship
		to: 0.
]

{ #category : #action }
NoEffect >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [

	spaceships
		moveForward: aSpaceship
		to: 0
		with: endPosition
		and: laps
]

{ #category : #initialization }
NoEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
