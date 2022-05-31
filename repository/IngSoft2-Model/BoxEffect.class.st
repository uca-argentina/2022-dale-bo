Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffect >> applyTo: ships triggeredBy: aShip with: endPosition and:laps [
 self subclassResponsibility.
]
