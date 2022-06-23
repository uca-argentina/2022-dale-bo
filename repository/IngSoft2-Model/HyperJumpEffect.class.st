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
HyperJumpEffect class >> assertPosibleMovesAreValid:aCollectionOfPosiblesMoves [
]

{ #category : #'class initialization' }
HyperJumpEffect class >> with: aCollectionOfPosiblesMoves [
	self assertPosibleMovesAreValid:aCollectionOfPosiblesMoves.
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #action }
HyperJumpEffect >> applyTo: spaceships triggeredBy: aSpaceship with: aBoard [

	aBoard 
		move: aSpaceship
		to: self numberOfDistanceByHyperJump
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

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [
	index:=0.
	posibleMoves:= aCollectionOfPosiblesMoves.
]

{ #category : #initialization }
HyperJumpEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]
