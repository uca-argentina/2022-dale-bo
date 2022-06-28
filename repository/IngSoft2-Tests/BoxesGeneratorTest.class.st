Class {
	#name : #BoxesGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoxesGeneratorTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
BoxesGeneratorTest >> testABoardCantBeCreatedBecauseDistributionsAreNotEnoughToCreateSomeBoxes [

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
						 NoEffect }
				 with: { 2. 8. 20. 10. 10. 50 }) boxSequence ]
		raise: Error
		withMessage:
		'Distribution of some boxes does not fit to create at least one box'
]

{ #category : #tests }
BoxesGeneratorTest >> testABoardIsCreatedWithRigthDistributions [

	| randomBoxes |
	randomBoxes := (BoxesGenerator
		                generate: 100
		                for: { 
				                AtomicBombEffect.
				                HyperJumpEffect.
				                MoonwalkEffect.
				                SpeedUpEffect.
				                WormHoleEffect.
				                NoEffect.
				                CardGiverEffect }
		                with: { 2. 8. 10. 20. 20. 30. 10 }) boxSequence.

	self assert: randomBoxes size equals: 100.
	
]
