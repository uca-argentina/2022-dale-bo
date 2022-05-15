Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> effect [
	^4
]

{ #category : #action }
SpeedUp >> effectTo: ships appliedBy: aShip [
	^{aShip}
]

{ #category : #action }
SpeedUp >> effectTo: ships appliedBy: aShip with:endPosition and:laps [
	ships moveForward: aShip to: (self effect) with:endPosition and:laps. 
]
