Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes'
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

{ #category : #initialization }
Board >> initializeWith: aNumberOfBoxes [

	boxes := aNumberOfBoxes.
]

{ #category : #accesing }
Board >> lastPosition [

	^ boxes
]
