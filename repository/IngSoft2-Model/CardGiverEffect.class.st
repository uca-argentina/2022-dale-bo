Class {
	#name : #CardGiverEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardGiverEffect >> applyTo: ships triggeredBy: aShip with: aCard distance: aDistance laps: laps and: aDeck [
 ships
		giveTo: aShip
		card: aDeck giveCard.
]
