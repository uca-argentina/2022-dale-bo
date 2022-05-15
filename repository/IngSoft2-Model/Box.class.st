Class {
	#name : #Box,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Box >> effect [
	^0.
]

{ #category : #action }
Box >> effectTo: ships appliedBy: aShip [

	
	^{aShip} .
]

{ #category : #action }
Box >> effectTo: ships appliedBy: aShip with:endPosition and:laps [
	ships moveForward: aShip to: (self effect) with:endPosition and:laps. 
]
