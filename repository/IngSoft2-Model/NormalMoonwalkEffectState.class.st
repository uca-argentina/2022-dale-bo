Class {
	#name : #NormalMoonwalkEffectState,
	#superclass : #BoxEffectState,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
NormalMoonwalkEffectState class >> with: aNumberOfBoxesToSendBack [ 
	^ self new initializeWith: aNumberOfBoxesToSendBack
]

{ #category : #action }
NormalMoonwalkEffectState >> initializeWith: aBox [
	retroPositions := aBox .
]

{ #category : #action }
NormalMoonwalkEffectState >> reverse [
	^ (ReversedMoonwalkEffectState with: retroPositions  ).
]

{ #category : #action }
NormalMoonwalkEffectState >> triggeredBy: aSpaceship with: aGame [

		(aGame board)
		moveBackwards: retroPositions negated
		allSpaceshipsExcept: aSpaceship
]
