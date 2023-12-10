Class {
	#name : #CardGiverEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardGiverEffect class >> with: aDeck [ 
	^self new initializeWith:aDeck.
]

{ #category : #initialization }
CardGiverEffect >> initializeWith: aDeck [ 
	state := NormalCardGiverEffectState with: aDeck.
]

{ #category : #action }
CardGiverEffect >> reverse [
	state := state reverse.
]

{ #category : #action }
CardGiverEffect >> triggeredBy: aSpaceship with: aGame [

	state triggeredBy: aSpaceship  with: aGame.
]
