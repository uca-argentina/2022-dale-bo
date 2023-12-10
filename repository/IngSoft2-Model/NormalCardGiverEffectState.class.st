Class {
	#name : #NormalCardGiverEffectState,
	#superclass : #BoxEffectState,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
NormalCardGiverEffectState class >> with: aDeck [ 
	^ self new initializeWith: aDeck.
]

{ #category : #initialization }
NormalCardGiverEffectState >> initializeWith: aDeck [ 
	deck := aDeck .
]

{ #category : #action }
NormalCardGiverEffectState >> reverse [
	^ ReversedCardGiverEffectState with: deck.
]

{ #category : #action }
NormalCardGiverEffectState >> triggeredBy: aSpaceship with: aGame [

	aGame giveTo: aSpaceship card: deck giveCard
]
