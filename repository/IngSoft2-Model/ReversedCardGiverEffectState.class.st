Class {
	#name : #ReversedCardGiverEffectState,
	#superclass : #BoxEffectState,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ReversedCardGiverEffectState class >> with: aDeck [ 
		^ self new initializeWith: aDeck.
]

{ #category : #initialization }
ReversedCardGiverEffectState >> initializeWith: aDeck [ 
	deck := aDeck.
]

{ #category : #action }
ReversedCardGiverEffectState >> reverse [
	^ NormalCardGiverEffectState with: deck.
]

{ #category : #action }
ReversedCardGiverEffectState >> triggeredBy: aSpaceship with: aGame [
	
	"do Nothing"
]
