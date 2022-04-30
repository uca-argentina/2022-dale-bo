Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'position',
		'board',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> withName: aName [
	^self new initializeWithName:aName.
]

{ #category : #action }
Ship >> changePositionTo: aPosition [ 
	position := aPosition.
]

{ #category : #initalize }
Ship >> initializeWithName: aName [ 
	name:=aName.
	position:=0.
]

{ #category : #accessing }
Ship >> name [
	^ name
]

{ #category : #accesing }
Ship >> positionOf [

	^position 
]
