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

{ #category : #private }
Player >> getName [
	^ name.
]

{ #category : #private }
Player >> getShip [

	^ship.
]

{ #category : #initialization }
Player >> initilizeWithName: aName andShip: aShip [

	name := aName.
	ship := aShip.
]

{ #category : #'as yet unclassified' }
Player >> moveItsShip:aSum [
	ship changePositionTo: aSum.
]

{ #category : #'as yet unclassified' }
Player >> roll: aDiceCup [ 
	^ aDiceCup roll.
]
