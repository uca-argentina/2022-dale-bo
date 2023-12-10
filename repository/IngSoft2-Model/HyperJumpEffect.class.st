Class {
	#name : #HyperJumpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'posibleMoves',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJumpEffect class >> assertPosibleMovesAreValid: aCollectionOfPosiblesMoves [

	aCollectionOfPosiblesMoves isEmpty ifTrue: [ 
		Error signal: 'There are no posible moves' ].
]

{ #category : #'class initialization' }
HyperJumpEffect class >> with: aCollectionOfPosiblesMoves [
	self assertPosibleMovesAreValid:aCollectionOfPosiblesMoves.
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #private }
HyperJumpEffect >> decreasingSort: aCollectionOfPosibleMoves [

	^aCollectionOfPosibleMoves sort: [ :distance1 :distance2 | 
		distance1 amountInParsecs >= distance2 amountInParsecs ].
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [
	index:=0.
	posibleMoves:= (self decreasingSort:aCollectionOfPosiblesMoves).
]

{ #category : #private }
HyperJumpEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #action }
HyperJumpEffect >> reverse [
	"do nothing"
]

{ #category : #action }
HyperJumpEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board)
		move: aSpaceship
		toFinalDistance: self numberOfDistanceByHyperJump
]
