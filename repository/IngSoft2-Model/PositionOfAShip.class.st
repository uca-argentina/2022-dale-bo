Class {
	#name : #PositionOfAShip,
	#superclass : #Object,
	#instVars : [
		'ship',
		'boxNumber',
		'lapNumber',
		'parsecNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
PositionOfAShip class >> assertBoxNumberIsGreaterThanZero: aBoxNumber [

	(aBoxNumber >= 0) ifFalse: [ 
		Error signal: 'Box number must be positive' ]
]

{ #category : #instanceCreation }
PositionOfAShip class >> assertLapNumberIsGreaterThanZero: aLapNumber [

	(aLapNumber >= 0) ifFalse: [ 
		Error signal: 'Lap number must be positive' ]
]

{ #category : #instanceCreation }
PositionOfAShip class >> assertShipsNameIsValid:aShip [
	(aShip size  > 1) ifFalse: [ 
		Error signal: 'Ship name must have a name longer than one character']
]

{ #category : #instanceCreation }
PositionOfAShip class >> of: aShip at: aBoxNumber parsecs: aNumberOfParsecs and: aLapNumber [

	self assertShipsNameIsValid: aShip.
	self assertBoxNumberIsGreaterThanZero: aBoxNumber.
	self assertLapNumberIsGreaterThanZero: aLapNumber.
	^ self new
		  initializeOf: aShip
		  at: aBoxNumber
		  parsecs: aNumberOfParsecs
		  and: aLapNumber
]

{ #category : #accesing }
PositionOfAShip >> boxNumber [

	^ boxNumber
]

{ #category : #initialization }
PositionOfAShip >> initializeOf: aShip at: aBoxNumber parsecs: aNumberOfParsecs and: aLapNumber [

	ship := aShip.
	boxNumber := aBoxNumber.
	parsecNumber := aNumberOfParsecs.
	lapNumber:=aLapNumber.
]

{ #category : #accesing }
PositionOfAShip >> lapNumber [

	^ lapNumber
]

{ #category : #accessing }
PositionOfAShip >> ownerShip [

	^ ship
]

{ #category : #accessing }
PositionOfAShip >> parsecNumber [

	^ parsecNumber 
]
