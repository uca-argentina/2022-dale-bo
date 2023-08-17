Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LoadedDie class >> assertValid: numberOfSides [ 
	numberOfSides > 0 ifFalse: [Error signal: 'Number of faces should be greater than 0' ].
]

{ #category : #'instance creation' }
LoadedDie class >> with: aNumberOfSides [
	self assertValid: aNumberOfSides.
	^self new initializeWith: aNumberOfSides
]

{ #category : #initialization }
LoadedDie >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #actions }
LoadedDie >> maxToss [

	^ numberOfSides
]

{ #category : #actions }
LoadedDie >> roll [

	^ numberOfSides
]
