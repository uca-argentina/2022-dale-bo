Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Box class >> parsecs: aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
Box >> effect [
	^0.
]

{ #category : #action }
Box >> effectTo: ships appliedBy: aShip with:endPosition and:laps [
	ships moveForward: aShip to: (self effect) with:endPosition and:laps. 
]

{ #category : #initialization }
Box >> initializeWith:aNumberOfParsecs [
	parsecs:= aNumberOfParsecs.
]
