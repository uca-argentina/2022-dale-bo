Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUp class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
SpeedUp >> effect [
	^4
]

{ #category : #action }
SpeedUp >> effectTo: ships appliedBy: aShip with:endPosition and:laps [
	ships moveForward: aShip to: (self effect) with:endPosition and:laps. 
]

{ #category : #action }
SpeedUp >> initializeWith:aNumberOfParsecs [
	parsecs:= aNumberOfParsecs.
]
