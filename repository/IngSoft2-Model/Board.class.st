Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: boxes [
	boxes isEmpty ifTrue: [ Error signal: 'A board must have at least one box' ].
]

{ #category : #asserting }
Board class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #creation }
Board class >> withAll: aCollectionOfBoxes and:laps [
	self assertValid: aCollectionOfBoxes.
	self assertValidLaps:laps.
	^self new initializeWith: aCollectionOfBoxes and:laps.
]

{ #category : #accesing }
Board >> effectAt: aBoxNumber [ 
	^(boxes at: aBoxNumber) effect.
]

{ #category : #actions }
Board >> effectAt: aBoxNumber for: ships appliedBy: aShip [ 
	^(boxes at:aBoxNumber) effectTo:ships appliedBy:aShip
]

{ #category : #initialization }
Board >> initializeWith: aCollectionOfBoxes and:numberOfLaps [

	boxes := aCollectionOfBoxes.
	laps:= numberOfLaps.
]

{ #category : #accessing }
Board >> laps [
	^laps
]

{ #category : #accesing }
Board >> lastPosition [
	^boxes size.
]
