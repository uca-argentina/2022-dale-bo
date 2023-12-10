Class {
	#name : #MoonwalkEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'state'
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
	state := (NormalMoonwalkEffectState with: aNumberOfBoxesToSendBack) .
]

{ #category : #action }
MoonwalkEffect >> reverse [ 
	
	state := state reverse.
	"retroPositions := retroPositions negated."
]

{ #category : #action }
MoonwalkEffect >> triggeredBy: aSpaceship with: aGame [

	state triggeredBy: aSpaceship  with: aGame 
]
