Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: block raise: classError whoseDescriptionIncludes: anErrorMessage [ 
	self 
		should: block
		raise: classError 
		whoseDescriptionIncludes: anErrorMessage
		description: 'Test did not fail as excepected'.
]

{ #category : #tests }
BoardTest >> testABoardIsCreatedWith10RandomGeneratedBoxes [

	| randomBoxes aBoard |
	"randomBoxes := (BoxesGenerator generateWith:10 and:200) boxSequence."
	randomBoxes := (BoxesGenerator
		                generate: 10
		                for: { 
				                AtomicBombEffect.
				                HyperJumpEffect.
				                MoonwalkEffect.
				                SpeedUpEffect.
				                WormHoleEffect.
				                NoEffectBox }
		                with: { 0.1. 0.1. 0.1. 0.1. 0.1. 0.5 }) boxSequence.
	aBoard := Board
		          ships: { 'Valen'. 'Pablo'. 'Seba' }
		          with: randomBoxes
		          distance: (Parsecs with: 200)
		          laps: 2
		          and: (Deck with: { SpeedCard new }).
	self assert: aBoard boxes size equals: 10
]
