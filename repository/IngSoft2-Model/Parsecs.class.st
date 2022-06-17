Class {
	#name : #Parsecs,
	#superclass : #Distance,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance cre' }
Parsecs class >> with: aTotalDistance [

	^ self new initializeWith: aTotalDistance
]

{ #category : #accesing }
Parsecs >> amount [

	^ amount
]

{ #category : #actions }
Parsecs >> amountInParsecs [

	^ amount
]

{ #category : #initialization }
Parsecs >> initializeWith: aDistance [

	amount := aDistance
]
