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
