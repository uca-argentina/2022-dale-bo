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
MoonwalkEffect >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [

	spaceships allSpaceships do: [ :each | 
		each nameOfSpaceship ~= aSpaceship ifTrue: [ 
			spaceships
				moveBackwards: each nameOfSpaceship
				to: self numberOfBoxesToMoonwalk
				with: endPosition
				and: laps ] ]
]

{ #category : #initialization }
MoonwalkEffect >> initializeWith: aNumberOfBoxesToSendBack [
	retroPositions:= aNumberOfBoxesToSendBack.
]

{ #category : #action }
MoonwalkEffect >> numberOfBoxesToMoonwalk [

	^ retroPositions
]
