Class {
	#name : #CardGiverReversedEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardGiverReversedEffect class >> with: aDeck [ 
	^self new initializeWith:aDeck.
]

{ #category : #actions }
CardGiverReversedEffect >> changePolarity [
	^ CardGiverEffect with: deck.
]

{ #category : #actions }
CardGiverReversedEffect >> initializeWith: aDeck [ 
	deck:= aDeck.
]

{ #category : #actions }
CardGiverReversedEffect >> triggeredBy: aSpaceship with: aGame [

	aGame giveToAllExcept: aSpaceship card: deck giveCard.
]
