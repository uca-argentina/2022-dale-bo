Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffect >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance and: laps [
 self subclassResponsibility.
]
