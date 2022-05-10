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
	boxes size > 0 ifFalse: [ Error signal: 'A board must have at least one box' ].
]

{ #category : #creation }
Board class >> withAll: aCollectionOfBoxes [ 
	self assertValid: aCollectionOfBoxes.
	^self new initializeWith: aCollectionOfBoxes.
]

{ #category : #initialization }
Board >> initializeWith: aCollection [

	boxes := aCollection.
]

{ #category : #accesing }
Board >> lastPosition [
	^boxes size.
]

{ #category : #accesing }
Board >> numberOfBoxes [
	^boxes size.
]
