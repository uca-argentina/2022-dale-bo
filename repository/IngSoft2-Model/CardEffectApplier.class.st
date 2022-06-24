Class {
	#name : #CardEffectApplier,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardEffectApplier >> apply: aCardPlay using: aBoard [

	aBoard allSpaceships do: [ :each | 
		aBoard
			updateSpaceshipEffectsOf: each
			to: (SpaceshipEffects with: ((each effectsOnSpaceship) effectsOnMe add: aCardPlay cardType)) ]
]
