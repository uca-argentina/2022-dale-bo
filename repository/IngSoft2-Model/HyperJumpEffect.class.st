Class {
	#name : #HyperJumpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'posibleMoves',
		'index',
		'state'
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

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [

	state := NormalHyperJumpEffect with: aCollectionOfPosiblesMoves.
]

{ #category : #action }
HyperJumpEffect >> reverse [
	state := state reverse.
]

{ #category : #action }
HyperJumpEffect >> triggeredBy: aSpaceship with: aGame [

	state triggeredBy: aSpaceship with: aGame.

	"(aGame board)
		move: aSpaceship
		toFinalDistance: self numberOfDistanceByHyperJump"
]
