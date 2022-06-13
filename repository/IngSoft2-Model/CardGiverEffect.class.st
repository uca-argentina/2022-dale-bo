Class {
	#name : #CardGiverEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardGiverEffect class >> with: aDeck [ 
	^self new initializeWith:aDeck.
]

{ #category : #action }
CardGiverEffect >> applyTo: ships triggeredBy: aShip with: aCard distance: aDistance laps: laps [
 ships
		giveTo: aShip
		card: deck giveCard.
]

{ #category : #initialization }
CardGiverEffect >> initializeWith: aDeck [ 
	deck:= aDeck.
]
