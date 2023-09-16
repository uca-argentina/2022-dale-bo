Class {
	#name : #MoonwalkReversedEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
MoonwalkReversedEffect class >> assertNumberOfBoxesIsPositive: aNumberOfBoxesToSendBack [

	aNumberOfBoxesToSendBack > 0 ifFalse: [ 
		Error signal: 'Number of boxes to send back muste be positive' ]
]

{ #category : #asserting }
MoonwalkReversedEffect class >> with: aNumberOfBoxesToSendBack [

	self assertNumberOfBoxesIsPositive:aNumberOfBoxesToSendBack.
	^ self new initializeWith: aNumberOfBoxesToSendBack
]

{ #category : #actions }
MoonwalkReversedEffect >> changePolarity [
	^ MoonwalkEffect with: retroPositions .
]

{ #category : #actions }
MoonwalkReversedEffect >> initializeWith: aNumberOfBoxesToSendBack [
	retroPositions:= aNumberOfBoxesToSendBack.
]

{ #category : #actions }
MoonwalkReversedEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: (retroPositions negated).
]
