Class {
	#name : #ShipPosition,
	#superclass : #Object,
	#instVars : [
		'ship',
		'boxNumber',
		'lapNumber',
		'parsecNumber',
		'hand',
		'effectsOnMe'
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

{ #category : #accesing }
ShipPosition >> effects [
	^effectsOnMe.
]

{ #category : #initialization }
ShipPosition >> initializeOf: aShip at: aBoxNumber parsecs: aNumberOfParsecs and: aLapNumber [

	ship := aShip.
	boxNumber := aBoxNumber.
	parsecNumber := aNumberOfParsecs.
	lapNumber:=aLapNumber.
	hand:= OrderedCollection new.
	effectsOnMe := 0.
]

{ #category : #action }
ShipPosition >> isAffectedBy: anEffect [
	effectsOnMe:= anEffect.
]

{ #category : #accesing }
ShipPosition >> lapNumber [

	^ lapNumber
]

{ #category : #action }
ShipPosition >> numberOfCards [
	^hand size.
]

{ #category : #accessing }
ShipPosition >> ownerShip [

	^ ship
]

{ #category : #accessing }
ShipPosition >> parsecNumber [

	^ parsecNumber 
]

{ #category : #action }
ShipPosition >> playACard: aCard to: aPlayer [ 
	aPlayer isAffectedBy: aCard effect.
]

{ #category : #action }
ShipPosition >> receive: aCard [ 
	hand add: aCard. 
]
