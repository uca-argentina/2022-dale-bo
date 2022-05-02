Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'ships',
		'sequenceController',
		'diceCup',
		'finished',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertCollectionOfShipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']


]

{ #category : #'instance creation' }
Game class >> withShips: aCollectionOfShips aBoard: aBoard shipsSequenceController: aSequenceController andDiceCup: aDiceCup [
	self assertCollectionOfShipsIsValid:aCollectionOfShips.
	^self new initializeWithShips:aCollectionOfShips withBoard: aBoard SequenceController:aSequenceController andWithDiceCup: aDiceCup.
]

{ #category : #accessing }
Game >> hasFinished [
	^ finished.
]

{ #category : #initialization }
Game >> initializeWithShips:aCollectionOfShips withBoard: aBoard 	SequenceController:aSequenceController andWithDiceCup: aDiceCup [
	ships:= aCollectionOfShips.
	board:= aBoard.
	sequenceController:= aSequenceController.
	diceCup:= aDiceCup.
	finished:= false.
	
]

{ #category : #action }
Game >> playATurn [
	| shipNewPosition |
	shipNewPosition:= diceCup roll + (sequenceController whoPlays) positionOf.
	(shipNewPosition >= board lastPosition) ifTrue: [shipNewPosition:= board lastPosition. 
	finished:= 	true. winner:= (sequenceController whoPlays) name].
	(sequenceController whoPlays) changePositionTo: shipNewPosition.
	(sequenceController changeTurn)
]

{ #category : #accesing }
Game >> positionOf: aShipsName [
	
	ships do: [ :each | ((each name) = aShipsName) ifTrue:[^ each positionOf] ].

]

{ #category : #actions }
Game >> winner [
	^ winner.
]
