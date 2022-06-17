Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
BoardTest >> testABoardCantBeCreatedBecauseOfDistributions [

	self
		should: [ 
			(BoxesGenerator
				 generate: 10
				 for: { 
						 AtomicBombEffect.
						 HyperJumpEffect.
						 MoonwalkEffect.
						 SpeedUpEffect.
						 WormHoleEffect.
						 NoEffectBox }
				 with: { 2. 8. 20. 10. 10. 50 }) boxSequence ]
		raise: Error
		withMessage:
		'Distribution of some boxes does not fit to create at least one box'
]

{ #category : #tests }
BoardTest >> testABoardIsCreatedWith10RandomGeneratedBoxes [

	| randomBoxes aBoard |
	randomBoxes := (BoxesGenerator
		                generate: 10
		                for: { 
				                AtomicBombEffect.
				                HyperJumpEffect.
				                MoonwalkEffect.
				                SpeedUpEffect.
				                WormHoleEffect.
				                NoEffectBox }
		                with: { 10. 10. 10. 10. 10. 50 }) boxSequence.
	aBoard := Board
		          ships: { 'Valen'. 'Pablo'. 'Seba' }
		          with: randomBoxes
		          distance: (Parsecs with: 200)
		          laps: 2
		          and: (Deck with: { SpeedCard new }).
	self assert: aBoard boxes size equals: 10
]

{ #category : #tests }
BoardTest >> testABoardIsCreatedWithRigthDistributions [

	| randomBoxes aBoard |
	randomBoxes := (BoxesGenerator
		                generate: 100
		                for: { 
				                AtomicBombEffect.
				                HyperJumpEffect.
				                MoonwalkEffect.
				                SpeedUpEffect.
				                WormHoleEffect.
				                NoEffectBox.
				                CardGiverEffect }
		                with: { 2. 8. 10. 20. 20. 30. 10 }) boxSequence.
	aBoard := Board
		          ships: { 'Valen'. 'Pablo'. 'Seba' }
		          with: randomBoxes
		          distance: (Parsecs with: 200)
		          laps: 2
		          and: (Deck with: { SpeedCard new }).
	self assert: aBoard boxes size equals: 100
]
