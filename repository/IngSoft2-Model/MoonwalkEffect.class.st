Class {
	#name : #MoonwalkEffect,
	#superclass : #Object,
	#instVars : [
		'retroPositions',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonwalkEffect class >> with: aNumberOfBoxesToSendBack and:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfBoxesToSendBack and:aNumberOfParsecs.
]

{ #category : #action }
MoonwalkEffect >> effect [
	^ 0- retroPositions.
]

{ #category : #'action handling' }
MoonwalkEffect >> effectTo: ships appliedBy: aShip with: endPosition and:laps [

	ships positions do: [ :each | 
		each ownerShip ~= aShip ifTrue: [ 
			ships moveBackwards: each ownerShip to: self effect with: endPosition and:laps] ]
]

{ #category : #initialization }
MoonwalkEffect >> initializeWith: aNumberOfBoxesToSendBack and:aNumberOfParsecs [
	retroPositions:= aNumberOfBoxesToSendBack.
	parsecs:= aNumberOfParsecs.
]
