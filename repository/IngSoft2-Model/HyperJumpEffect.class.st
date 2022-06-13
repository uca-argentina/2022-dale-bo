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
HyperJumpEffect class >> with: aCollectionOfPosiblesMoves [

	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #action }
HyperJumpEffect >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance laps: laps [
 ships
		move: aShip
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
