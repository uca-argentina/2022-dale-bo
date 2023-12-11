Class {
	#name : #ReversedHyperJumpEffect,
	#superclass : #BoxEffectState,
	#instVars : [
		'index',
		'posibleMoves'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ReversedHyperJumpEffect class >> with: aCollectionOfPosiblesMoves [ 
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #action }
ReversedHyperJumpEffect >> decreasingSort: aCollectionOfPosibleMoves [

	^aCollectionOfPosibleMoves sort: [ :distance1 :distance2 | 
		distance1 amountInParsecs >= distance2 amountInParsecs ].
]

{ #category : #action }
ReversedHyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [
	index:=0.
	posibleMoves:= (self decreasingSort:aCollectionOfPosiblesMoves).
]

{ #category : #action }
ReversedHyperJumpEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #action }
ReversedHyperJumpEffect >> reverse [
	^ NormalHyperJumpEffect with: posibleMoves.
]

{ #category : #action }
ReversedHyperJumpEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board)
		moveBackwards: aSpaceship
		toFinalDistance: self numberOfDistanceByHyperJump
]
