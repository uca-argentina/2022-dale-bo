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
BoardTest >> testABoardCannotBeCreatedWithZeroBoxes [



	self
		should: [Board
		          players: { 'Valen'. 'Pablo'. 'Seba' }
		          withBoxes: {}
		          distance: 200
		          and: 2.  ]
		raise: Error
		whoseDescriptionIncludes: 'A board must have at least one box'
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
		                with: {0.1. 0.1. 0.1 . 0.1. 0.1. 0.5 }) boxSequence.
	aBoard := Board players:{'Valen'. 'Pablo'. 'Seba'} withBoxes:randomBoxes distance:200 and:2.
	self assert: aBoard boxes size equals: 10.
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAPositiveDistanceAndGreatearThan0 [

	| randomBoxes |
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
	self
		should: [ 
			Board
				players: { 'Valen'. 'Pablo'. 'Seba' }
				withBoxes: randomBoxes  
				distance: 0
				and: 2]
		raise: Error
		whoseDescriptionIncludes: 'A board must have a distance greater than zero'
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneLap [

	| randomBoxes |
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
	self
		should: [ 
			Board
				players: { 'Valen'. 'Pablo'. 'Seba' }
				withBoxes:  randomBoxes  
				distance: 200
				and: 0 ]
		raise: Error
		whoseDescriptionIncludes: 'A board must have at least one lap'
]
