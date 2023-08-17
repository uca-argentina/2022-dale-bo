Class {
	#name : #Parsecs,
	#superclass : #Distance,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance cre' }
Parsecs class >> assertDistanceIsValid:aDistance [

	aDistance < 0 ifTrue: [ 
		Error signal: 'Distances must be greater than zero' ]
]

{ #category : #'instance cre' }
Parsecs class >> with: aTotalDistance [

	self assertDistanceIsValid: aTotalDistance.
	^ self new initializeWith: aTotalDistance
]

{ #category : #actions }
Parsecs >> amountInParsecs [

	^ amount
]

{ #category : #initialization }
Parsecs >> initializeWith: aDistance [

	amount := aDistance
]

{ #category : #accesing }
Parsecs >> negative [

	^ amount < 1
]
