Class {
	#name : #SpeedUpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpEffect class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
SpeedUpEffect >> applyTo: ships triggeredBy: aShip with: endPosition and:laps [
 ships
		moveForward: aShip
		to: self effect
		with: endPosition
		and: laps
]

{ #category : #action }
SpeedUpEffect >> effect [
	^4
]

{ #category : #action }
SpeedUpEffect >> initializeWith:aNumberOfParsecs [
	parsecs:= aNumberOfParsecs.
]
