Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> effect [
	^-4.
]

{ #category : #action }
WormHole >> effectTo: ships appliedBy: aShip [
	^{aShip}
]

{ #category : #action }
WormHole >> effectTo: ships appliedBy: aShip with:endPosition and:laps [
	ships moveBackwards: aShip to: (self effect) with:endPosition and:laps. 
]
