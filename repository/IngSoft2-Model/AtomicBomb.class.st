Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
AtomicBomb class >> with: numberOfBoardBoxes [
 
	^self new initializeWith:numberOfBoardBoxes.
]

{ #category : #action }
AtomicBomb >> effect [
	^retroPositions.
]

{ #category : #action }
AtomicBomb >> effectTo: ships appliedBy: aShip with: endPosition and:laps [
	ships applyAtomicBomb.
]

{ #category : #initialization }
AtomicBomb >> initializeWith: numberOfBoardBoxes [ 
	retroPositions:= 0-numberOfBoardBoxes .
]
