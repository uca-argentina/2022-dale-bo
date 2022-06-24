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
CardGiverEffect >> applyTo: spaceships triggeredBy: aSpaceship with: aCard distance: aDistance laps: laps [
 spaceships
		giveTo: aSpaceship
		card: deck giveCard.
]

{ #category : #initialization }
CardGiverEffect >> initializeWith: aDeck [ 
	deck:= aDeck.
]

{ #category : #action }
CardGiverEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard 
		giveTo: aSpaceship
		card: deck giveCard.
]
