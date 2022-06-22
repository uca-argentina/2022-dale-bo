Class {
	#name : #SpaceshipEffects,
	#superclass : #Object,
	#instVars : [
		'effectsOnSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipEffects class >> with: aCollectionOfEffects [

	^self new initializeWith:aCollectionOfEffects.
]

{ #category : #initialization }
SpaceshipEffects >> initializeWith: aCollectionOfEffects [ 
	effectsOnSpaceship:=aCollectionOfEffects.
]

{ #category : #initialization }
SpaceshipEffects >> sumOfCardsEffects [

	| sum |
	sum := 0.
	effectsOnSpaceship do: [ :each | sum := sum + each effect ].
	^ sum
]
