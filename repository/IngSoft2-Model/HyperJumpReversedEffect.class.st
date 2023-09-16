Class {
	#name : #HyperJumpReversedEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'posibleMoves',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpReversedEffect class >> assertPosibleMovesAreValid: aCollectionOfPosiblesMoves [

	aCollectionOfPosiblesMoves isEmpty ifTrue: [ 
		Error signal: 'There are no posible moves' ].
]

{ #category : #asserting }
HyperJumpReversedEffect class >> with: aCollectionOfPosiblesMoves [
	self assertPosibleMovesAreValid:aCollectionOfPosiblesMoves.
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #actions }
HyperJumpReversedEffect >> changePolarity [
	^ HyperJumpEffect with: posibleMoves 
]

{ #category : #private }
HyperJumpReversedEffect >> decreasingSort: aCollectionOfPosibleMoves [

	^aCollectionOfPosibleMoves sort: [ :distance1 :distance2 | 
		distance1 amountInParsecs >= distance2 amountInParsecs ].
]

{ #category : #private }
HyperJumpReversedEffect >> initializeWith: aCollectionOfPosiblesMoves [
	index:=0.
	posibleMoves:= (self decreasingSort:aCollectionOfPosiblesMoves).
]

{ #category : #private }
HyperJumpReversedEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #private }
HyperJumpReversedEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board)
		moveAllSpaceshipsExcept: aSpaceship
		toFinalDistance: self numberOfDistanceByHyperJump
]
