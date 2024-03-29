Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Die class >> assertValid: numberOfSides [ 
	numberOfSides > 2 ifFalse: [Error signal: 'Number of faces should be greater than 2' ].
]

{ #category : #'instance creation' }
Die class >> with: aNumberOfSides [ 
	self assertValid: aNumberOfSides.
	^self new initializeWith: aNumberOfSides
]

{ #category : #initialization }
Die >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #accesing }
Die >> numberOfSides [

	^ numberOfSides
]

{ #category : #actions }
Die >> roll [

	^ numberOfSides atRandom
]
