Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Player class >> withName: aName withShips: aSetOfShips [ 
	^self new initilizeWithName:aName andShips:aSetOfShips.
]

{ #category : #private }
Player >> getName [
	^ name.
]

{ #category : #private }
Player >> getShips [

	^ships.
]

{ #category : #initialization }
Player >> initilizeWithName: aName andShips: aSetOfShips [
	name:=aName.
	ships:= aSetOfShips.
]

{ #category : #'as yet unclassified' }
Player >> move: aShip diceResult: aSum [ 
	aShip changePositionTo: aSum.
]
