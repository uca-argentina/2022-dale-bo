Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: boxes [
	boxes > 0 ifFalse: [ Error signal: 'A board must have at least one box' ].
]

{ #category : #creation }
Board class >> with: numberOfBoxes [ 
	self assertValid: numberOfBoxes.
	^self new initializeWith: numberOfBoxes.
]

{ #category : #accesing }
Board >> boxes [
	^boxes
]

{ #category : #accesing }
Board >> changeState: aState [
	state:= aState.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfBoxes [
	boxes := aNumberOfBoxes.
	state:= true.
]

{ #category : #accesing }
Board >> lastPosition [
	^self boxes.
]

{ #category : #accesing }
Board >> state [
	^ state.
]
