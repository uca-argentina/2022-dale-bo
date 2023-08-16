Class {
	#name : #MoonwalkEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonwalkEffect class >> assertNumberOfBoxesIsPositive: aNumberOfBoxesToSendBack [

	aNumberOfBoxesToSendBack > 0 ifFalse: [ 
		Error signal: 'Number of boxes to send back muste be positive' ]
]

{ #category : #'instance creation' }
MoonwalkEffect class >> with: aNumberOfBoxesToSendBack [

	self assertNumberOfBoxesIsPositive:aNumberOfBoxesToSendBack.
	^ self new initializeWith: aNumberOfBoxesToSendBack
]

{ #category : #initialization }
MoonwalkEffect >> initializeWith: aNumberOfBoxesToSendBack [
	retroPositions:= aNumberOfBoxesToSendBack.
]

{ #category : #action }
MoonwalkEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board)
		moveBackwards: retroPositions negated
		allSpaceshipsExcept: aSpaceship
]
