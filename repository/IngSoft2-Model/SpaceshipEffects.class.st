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

{ #category : #accessing }
SpaceshipEffects >> effectsOnMe [
	^effectsOnSpaceship.
]

{ #category : #initialization }
SpaceshipEffects >> initializeWith: aCollectionOfEffects [ 
	effectsOnSpaceship:=aCollectionOfEffects.
]

{ #category : #initialization }
SpaceshipEffects >> sumOfCardsEffects [

	
	^effectsOnSpaceship sum.
	
]
