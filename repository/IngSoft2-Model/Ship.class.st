Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ship class >> initialize [

	^self new initializeAtPosition.
]

{ #category : #'as yet unclassified' }
Ship >> changePositionTo: aSum [ 
	position:=position + aSum.
]

{ #category : #'as yet unclassified' }
Ship >> getPosition [

	^position 
]

{ #category : #initialization }
Ship >> initializeAtPosition [

	position:=0.
]
