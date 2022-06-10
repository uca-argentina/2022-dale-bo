Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffect >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance laps: laps and: aDeck [
 self subclassResponsibility.
]
