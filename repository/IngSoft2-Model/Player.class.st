Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'ship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validating }
Player class >> assertNameIsValid: aName [ 
	(aName size > 0 and: aName className = 'ByteString') ifFalse: [ 
		Error signal: 'Name must have at least one character and be a string' ].
]

{ #category : #validation }
Player class >> assertPlayerHasShip: aShip [ 
	aShip className = 'Ship' ifFalse: [ 
		Error signal: 'Player must have a ship as gamepiece']
]

{ #category : #instanceCreation }
Player class >> withName: aName withShip: aShip [
	self assertNameIsValid:aName.
	self assertPlayerHasShip: aShip.
	^self new initilizeWithName:aName andShip:aShip.
]

{ #category : #initialization }
Player >> initilizeWithName: aName andShip: aShip [

	name := aName.
	ship := aShip.
]

{ #category : #action }
Player >> moveItsShip:aDiceCup [
	| aSum |
	aSum := self roll: aDiceCup.
	ship changePositionTo: aSum.
]

{ #category : #accesing }
Player >> name [
	^ name.
]

{ #category : #action }
Player >> roll: aDiceCup [ 
	^ aDiceCup roll.
]

{ #category : #accesing }
Player >> ship [

	^ship.
]
