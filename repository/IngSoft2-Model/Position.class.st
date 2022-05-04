Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'ship',
		'boxNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Position class >> of: aShip at: aBoxNumber [ 
	^self new initializeOf:aShip at:aBoxNumber.
]

{ #category : #'instance creation' }
Position class >> withOwner: aName andAPosition: aPosition [
	^self new initializeWithOwner: aName andAPosition:aPosition .
]

{ #category : #accesing }
Position >> boxNumber [


	^boxNumber 
]

{ #category : #initialization }
Position >> initializeOf: aShip at: aBoxNumber [ 
	ship:= aShip.
	boxNumber:= aBoxNumber.
]

{ #category : #accessing }
Position >> owner [
	^ ship
]
