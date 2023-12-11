Class {
	#name : #TurnSequence,
	#superclass : #Object,
	#instVars : [
		'turnNumber',
		'spaceshipsNames'
	],
	#classInstVars : [
		'ships',
		'turnNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnSequence class >> with: aCollectionOfNames [

	^ self new initializeWith: aCollectionOfNames
]

{ #category : #initialization }
TurnSequence >> initializeWith: aCollectionOfNames [

	spaceshipsNames := aCollectionOfNames.
	turnNumber := 1
]

{ #category : #action }
TurnSequence >> next [

	turnNumber := turnNumber + 1.
	turnNumber > spaceshipsNames size ifTrue: [ turnNumber := 1 ]
]

{ #category : #action }
TurnSequence >> whoPlays [

	^ (spaceshipsNames at: turnNumber).
]
