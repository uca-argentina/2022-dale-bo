Class {
	#name : #HyperJumpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'posibleMoves',
		'parsecs',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJumpEffect class >> assertPosibleMovesAreValid: aCollectionOfPosiblesMoves [

	aCollectionOfPosiblesMoves size < 1 ifTrue: [ 
		Error signal: 'There are no posible moves' ].
	(aCollectionOfPosiblesMoves select: [ :element | element amount <= 0 ]) 
		ifNotEmpty: [ Error signal: 'Possbile moves cannot be negative' ]
]

{ #category : #'class initialization' }
HyperJumpEffect class >> with: aCollectionOfPosiblesMoves [
	self assertPosibleMovesAreValid:aCollectionOfPosiblesMoves.
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #action }
HyperJumpEffect >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [
 spaceships
		move: aSpaceship
		to: self numberOfDistanceByHyperJump
		finalDistance: aDistance
		with: endPosition
		and: laps
]

{ #category : #accessing }
HyperJumpEffect >> decreasingSort: aCollectionOfPosibleMoves [

	^aCollectionOfPosibleMoves sort: [ :distance1 :distance2 | 
		distance1 amountInParsecs >= distance2 amountInParsecs ].
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [
	index:=0.
	posibleMoves:= (self decreasingSort:aCollectionOfPosiblesMoves).
]

{ #category : #initialization }
HyperJumpEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #action }
HyperJumpEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard 
		move: aSpaceship
		to: self numberOfDistanceByHyperJump
]
