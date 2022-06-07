Class {
	#name : #ShipPosition,
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
ShipPosition class >> assertShipsNameIsValid:aShip [
	(aShip size  > 1) ifFalse: [ 
		Error signal: 'Ship name must have a name longer than one character']
]

{ #category : #instanceCreation }
ShipPosition class >> of: aShip at: aBoxNumber distance: aNumberOfParsecs and: aLapNumber [

	self assertShipsNameIsValid: aShip.
	^ self new
		  initializeOf: aShip
		  at: aBoxNumber
		  parsecs: aNumberOfParsecs
		  and: aLapNumber
]

{ #category : #accesing }
ShipPosition >> boxNumber [

	^ boxNumber
]

{ #category : #initialization }
ShipPosition >> initializeOf: aShip at: aBoxNumber parsecs: aNumberOfParsecs and: aLapNumber [

	ship := aShip.
	boxNumber := aBoxNumber.
	parsecNumber := aNumberOfParsecs.
	lapNumber:=aLapNumber.
]

{ #category : #accesing }
ShipPosition >> lapNumber [

	^ lapNumber
]

{ #category : #accessing }
ShipPosition >> ownerShip [

	^ ship
]

{ #category : #accessing }
ShipPosition >> parsecNumber [

	^ parsecNumber 
]
