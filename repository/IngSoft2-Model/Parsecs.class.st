Class {
	#name : #Parsecs,
	#superclass : #Distance,
	#instVars : [
		'totalParsecDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance cre' }
Parsecs class >> with: aTotalDistance [ 
	^self new initializeWith:aTotalDistance.
]

{ #category : #actions }
Parsecs >> calculateParsec: aDistance [
 totalParsecDistance := aDistance.
]

{ #category : #initialization }
Parsecs >> initializeWith: aTotalDistance [
	self calculateParsec: aTotalDistance.
]

{ #category : #accesing }
Parsecs >> units [
	^ totalParsecDistance.
]
