Class {
	#name : #TurnSequence,
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
TurnSequence class >> with: aCollectionOfShips [
	^self new initializeWith:aCollectionOfShips.
]

{ #category : #initialization }
TurnSequence >> initializeWith: aCollectionOfShips [

	ships := aCollectionOfShips.
	turnNumber := 1
]

{ #category : #action }
TurnSequence >> next [

	| actualTurn |
	actualTurn := ships at: turnNumber.
	turnNumber := turnNumber + 1.
	turnNumber > ships size ifTrue: [ turnNumber := 1 ].
	^ actualTurn
]
