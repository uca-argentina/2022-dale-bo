Class {
	#name : #SequenceController,
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
SequenceController class >> withShips: aCollectionOfShips [
	^self new initializeWithShips:aCollectionOfShips.
]

{ #category : #actions }
SequenceController >> changeTurn [
	(turnNumber < ships  size)
    ifTrue: [turnNumber := turnNumber + 1.]
    ifFalse: [ turnNumber := 1 ]
]

{ #category : #initialization }
SequenceController >> initializeWithShips: aCollectionOfShips [
	ships:= aCollectionOfShips.
	turnNumber:=1.
]

{ #category : #action }
SequenceController >> whoPlays [ 
	^ ships at:turnNumber.
]
