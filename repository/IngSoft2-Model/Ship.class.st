Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'position',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Ship class >> assertBoardIsValid: aBoard [ 
	aBoard className = 'Board' ifFalse: [ 
		Error signal: 'Ship must have a board']
]

{ #category : #initialization }
Ship class >> withBoard: aBoard [

	self assertBoardIsValid:aBoard.

	^self new initializeAtPositionZeroAndBoard:aBoard.
]

{ #category : #'as yet unclassified' }
Ship >> changePositionTo: aSum [ 
	position:=position + aSum.
	(position > board lastPosition) ifTrue:[position:= board lastPosition. board changeState:false.]. 
]

{ #category : #initialization }
Ship >> initializeAtPositionZeroAndBoard:aBoard [

	position:=0.
	board:= aBoard.
]

{ #category : #'as yet unclassified' }
Ship >> positionOf [

	^position 
]
