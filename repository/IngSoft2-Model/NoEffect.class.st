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

{ #category : #initialization }
NoEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]

{ #category : #action }
NoEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard
		moveForward: aSpaceship
		to: 0.
]
