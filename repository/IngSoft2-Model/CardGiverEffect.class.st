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

{ #category : #initialization }
CardGiverEffect >> initializeWith: aDeck [ 
	deck:= aDeck.
]

{ #category : #action }
CardGiverEffect >> reverse [
	
]

{ #category : #action }
CardGiverEffect >> triggeredBy: aSpaceship with: aGame [

	aGame giveTo: aSpaceship card: deck giveCard
]
