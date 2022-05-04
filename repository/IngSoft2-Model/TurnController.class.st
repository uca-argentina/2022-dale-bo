Class {
	#name : #TurnController,
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
TurnController class >> withShips: aCollectionOfShips [
	^self new initializeWithShips:aCollectionOfShips.
]

{ #category : #actions }
TurnController >> changeTurn [
	(turnNumber < ships  size)
    ifTrue: [turnNumber := turnNumber + 1.]
    ifFalse: [ turnNumber := 1 ]
]

{ #category : #initialization }
TurnController >> initializeWithShips: aCollectionOfShips [
	ships:= aCollectionOfShips.
	turnNumber:=1.
]

{ #category : #action }
TurnController >> whoPlays [ 
	^ ships at:turnNumber.
]
