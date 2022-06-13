Class {
	#name : #MoonwalkEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'retroPositions',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonwalkEffect class >> with: aNumberOfBoxesToSendBack [

	^ self new initializeWith: aNumberOfBoxesToSendBack
]

{ #category : #action }
MoonwalkEffect >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance laps: laps [
 ships positions do: [ :each | 
		each ownerShip ~= aShip ifTrue: [ 
			ships moveBackwards: each ownerShip to: self numberOfBoxesToMoonwalk with: endPosition and:laps] ]
]

{ #category : #initialization }
MoonwalkEffect >> initializeWith: aNumberOfBoxesToSendBack [
	retroPositions:= aNumberOfBoxesToSendBack.
]

{ #category : #action }
MoonwalkEffect >> numberOfBoxesToMoonwalk [
	^ retroPositions.
]
