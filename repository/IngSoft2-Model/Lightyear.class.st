Class {
	#name : #Lightyear,
	#superclass : #Distance,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Lightyear class >> with: aDistance [

	^ self new initializeWith: aDistance
]

{ #category : #accesing }
Lightyear >> amount [

	^ amount
]

{ #category : #actions }
Lightyear >> amountInParsecs [

	^ amount / 3
]

{ #category : #initialize }
Lightyear >> initializeWith: aDistance [

	amount := aDistance
]
