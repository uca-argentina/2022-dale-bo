Class {
	#name : #Lightyear,
	#superclass : #Distance,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Lightyear class >> assertDistanceIsValid:aDistance [
	aDistance < 0 ifTrue: [ 
		Error signal: 'Distances must be greater than zero' ]
]

{ #category : #'instance creation' }
Lightyear class >> with: aDistance [

	^ self new initializeWith: aDistance
]

{ #category : #actions }
Lightyear >> amountInParsecs [

	^ amount / 3
]

{ #category : #initialize }
Lightyear >> initializeWith: aDistance [

	amount := aDistance
]

{ #category : #accesing }
Lightyear >> negative [
	^ amount < 1
]
