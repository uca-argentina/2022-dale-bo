Class {
	#name : #Parsecs,
	#superclass : #Object,
	#instVars : [
		'totalParsecDistance',
		'totalLigthyearDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance cre' }
Parsecs class >> with: aTotalDistance [ 
	^self new initializeWith:aTotalDistance.
]

{ #category : #actions }
Parsecs >> calculateLightyear: aParsecDistance [ 
	^ aParsecDistance*3.
]

{ #category : #initialization }
Parsecs >> initializeWith: aTotalDistance [
	totalParsecDistance:= aTotalDistance.
	totalLigthyearDistance := (self calculateLightyear: totalParsecDistance).
]

{ #category : #accesing }
Parsecs >> units [
	^ totalParsecDistance.
]
