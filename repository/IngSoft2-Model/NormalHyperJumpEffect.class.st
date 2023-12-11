Class {
	#name : #NormalHyperJumpEffect,
	#superclass : #BoxEffectState,
	#instVars : [
		'index',
		'posibleMoves'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
NormalHyperJumpEffect class >> with: aCollectionOfPosiblesMoves [ 
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #initialization }
NormalHyperJumpEffect >> decreasingSort: aCollectionOfPosibleMoves [

	^aCollectionOfPosibleMoves sort: [ :distance1 :distance2 | 
		distance1 amountInParsecs >= distance2 amountInParsecs ].
]

{ #category : #initialization }
NormalHyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [ 
	index:=0.
	posibleMoves:= (self decreasingSort:aCollectionOfPosiblesMoves).
]

{ #category : #initialization }
NormalHyperJumpEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #action }
NormalHyperJumpEffect >> reverse [
	^ ReversedHyperJumpEffect with: posibleMoves 
]
