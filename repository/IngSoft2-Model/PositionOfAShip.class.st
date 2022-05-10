Class {
	#name : #PositionOfAShip,
	#superclass : #Object,
	#instVars : [
		'ship',
		'boxNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
PositionOfAShip class >> assertBoxNumberIsGreaterThanZero: aBoxNumber [

	aBoxNumber >= 0 ifFalse: [ 
		Error signal: 'Box number must be positive' ]
]

{ #category : #instanceCreation }
PositionOfAShip class >> assertShipsNameIsValid:aShip [
	(aShip size  > 1) ifFalse: [ 
		Error signal: 'Ship name must have a name longer than one character']
]

{ #category : #instanceCreation }
PositionOfAShip class >> of: aShip at: aBoxNumber [
	self assertShipsNameIsValid:aShip.
	self assertBoxNumberIsGreaterThanZero: aBoxNumber.
	^self new initializeOf:aShip at:aBoxNumber.
]

{ #category : #accesing }
PositionOfAShip >> boxNumber [

	^ boxNumber
]

{ #category : #initialization }
PositionOfAShip >> initializeOf: aShip at: aBoxNumber [

	ship := aShip.
	boxNumber := aBoxNumber
]

{ #category : #accessing }
PositionOfAShip >> ownerShip [

	^ ship
]
