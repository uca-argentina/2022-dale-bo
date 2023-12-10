Class {
	#name : #ReversedMoonwalkEffectState,
	#superclass : #BoxEffectState,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ReversedMoonwalkEffectState class >> with: aNumberOfBoxesToSendBack [ 
	^ self new initializeWith: aNumberOfBoxesToSendBack
]

{ #category : #initialization }
ReversedMoonwalkEffectState >> initializeWith: aBox [ 
	retroPositions := aBox .
]

{ #category : #action }
ReversedMoonwalkEffectState >> reverse [
	^ (NormalMoonwalkEffectState with: retroPositions ).
]

{ #category : #action }
ReversedMoonwalkEffectState >> triggeredBy: aSpaceship with: aGame [

		(aGame board)
		moveBackwards: retroPositions
		allSpaceshipsExcept: aSpaceship
]
