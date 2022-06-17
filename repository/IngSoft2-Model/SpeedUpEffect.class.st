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
SpeedUpEffect >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [
 spaceships
		moveForward: aSpaceship
		to: self boxesToSpeedUp
		with: endPosition
		and: laps
]

{ #category : #action }
SpeedUpEffect >> boxesToSpeedUp [

	^ 4
]

{ #category : #action }
SpeedUpEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
