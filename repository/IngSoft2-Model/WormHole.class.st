Class {
	#name : #WormHole,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHole class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
WormHole >> effect [
	^-4.
]

{ #category : #action }
WormHole >> effectTo: ships appliedBy: aShip with:endPosition and:laps [
	ships moveBackwards: aShip to: (self effect) with:endPosition and:laps. 
]

{ #category : #action }
WormHole >> initializeWith:aNumberOfParsecs [
 
	parsecs:= aNumberOfParsecs .
]
