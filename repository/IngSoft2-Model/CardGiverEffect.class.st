Class {
	#name : #CardGiverEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardGiverEffect >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance and: laps [
 ships
		giveTo: aShip
		card: Card new.
]
