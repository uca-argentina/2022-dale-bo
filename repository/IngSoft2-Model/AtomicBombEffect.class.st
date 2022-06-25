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

{ #category : #initialization }
AtomicBombEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]

{ #category : #action }
AtomicBombEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard moveSpaceshipsToTheFirstBox.
]
