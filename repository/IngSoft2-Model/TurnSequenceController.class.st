Class {
	#name : #TurnSequenceController,
	#superclass : #Object,
	#instVars : [
		'ships',
		'turnNumber'
	],
	#classInstVars : [
		'ships',
		'turnNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnSequenceController class >> with: aCollectionOfShips [
	^self new initializeWith:aCollectionOfShips.
]

{ #category : #actions }
TurnSequenceController >> changeTurn [
	turnNumber := turnNumber + 1.
	turnNumber > ships size
		ifTrue: [ turnNumber := 1 ]
]

{ #category : #initialization }
TurnSequenceController >> initializeWith: aCollectionOfShips [

	ships := aCollectionOfShips.
	turnNumber := 1
]

{ #category : #action }
TurnSequenceController >> whoPlays [

	^ ships at: turnNumber
]
