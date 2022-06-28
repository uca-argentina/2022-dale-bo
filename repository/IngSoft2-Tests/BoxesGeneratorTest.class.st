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
BoxesGeneratorTest >> testBoxesGeneratorCantCreateASequenceBeacauseTheProbabilityOfOneEffectsNotEnoughToCreateOneBox [

	| noEffectBox speedUpBox moonwalkBox effectsDistributions atomicBombBox wormholeEffectBox hyperjumpBox cardGiverBox deck |
	deck := Deck with: { SpeedCard new }.
	noEffectBox := DiscreteProbabilityEvent for: NoEffect new with: 30.
	speedUpBox := DiscreteProbabilityEvent
		              for: SpeedUpEffect new
		              with: 20.
	moonwalkBox := DiscreteProbabilityEvent
		               for: (MoonwalkEffect with: 2)
		               with: 10.
	atomicBombBox := DiscreteProbabilityEvent
		                 for: AtomicBombEffect new
		                 with: 2.
	wormholeEffectBox := DiscreteProbabilityEvent
		                     for: WormHoleEffect new
		                     with: 20.
	hyperjumpBox := DiscreteProbabilityEvent
		                for: (HyperJumpEffect with: { 
					                 (Parsecs with: 2).
					                 (Lightyear with: 12) })
		                with: 8.
	cardGiverBox := DiscreteProbabilityEvent
		                for: (CardGiverEffect with: deck)
		                with: 10.
	effectsDistributions := { 
		                        noEffectBox.
		                        speedUpBox.
		                        moonwalkBox.
		                        atomicBombBox.
		                        wormholeEffectBox.
		                        hyperjumpBox.
		                        cardGiverBox }.
	self
		should: [ 
		(BoxesGenerator generate: 10 for: effectsDistributions) boxSequence ]
		raise: Error
		withMessage:
		'Distribution of some boxes does not fit to create at least one box'
]

{ #category : #tests }
BoxesGeneratorTest >> testBoxesGeneratorCreatesOneHundredBoxesWithDistributions [

	| noEffectBox speedUpBox moonwalkBox effectsDistributions boxes atomicBombBox wormholeEffectBox hyperjumpBox cardGiverBox deck |
	deck:= Deck with:{SpeedCard new}.
	noEffectBox:=DiscreteProbabilityEvent for:(NoEffect new) with:30.
	speedUpBox:= DiscreteProbabilityEvent for:(SpeedUpEffect new) with:20.
	moonwalkBox:= DiscreteProbabilityEvent for:(MoonwalkEffect with:2) with:10.
	atomicBombBox:= DiscreteProbabilityEvent for:(AtomicBombEffect new) with:2.
	wormholeEffectBox:= DiscreteProbabilityEvent for:(WormHoleEffect new) with:20.
	hyperjumpBox:= DiscreteProbabilityEvent for:(HyperJumpEffect with:{Parsecs with:2. Lightyear with:12}) with:8.
	cardGiverBox:= DiscreteProbabilityEvent for:(CardGiverEffect with:deck) with:10.
	effectsDistributions:= { noEffectBox. speedUpBox. moonwalkBox.atomicBombBox. wormholeEffectBox. hyperjumpBox. cardGiverBox. }.
	boxes:= (BoxesGenerator generate: 100 for: effectsDistributions) boxSequence.
	self assert: boxes size equals:100.
	
]

{ #category : #tests }
BoxesGeneratorTest >> testBoxesGeneratorProbabilitiesCantBeLowerThanOneHundred [

	| noEffectBox speedUpBox moonwalkBox effectsDistributions atomicBombBox wormholeEffectBox hyperjumpBox cardGiverBox deck |
	deck:= Deck with:{SpeedCard new}.
	noEffectBox := DiscreteProbabilityEvent for: NoEffect new with: 30.
	speedUpBox := DiscreteProbabilityEvent
		              for: SpeedUpEffect new
		              with: 20.
	moonwalkBox := DiscreteProbabilityEvent
		               for: (MoonwalkEffect with: 2)
		               with: 8.
	atomicBombBox := DiscreteProbabilityEvent
		                 for: AtomicBombEffect new
		                 with: 2.
	wormholeEffectBox := DiscreteProbabilityEvent
		                     for: WormHoleEffect new
		                     with: 20.
	hyperjumpBox := DiscreteProbabilityEvent
		                for: (HyperJumpEffect with: { 
					                 (Parsecs with: 2).
					                 (Lightyear with: 12) })
		                with: 8.
	cardGiverBox := DiscreteProbabilityEvent
		                for: (CardGiverEffect with:deck)
		                with: 10.
	effectsDistributions := { 
		                        noEffectBox.
		                        speedUpBox.
		                        moonwalkBox.
		                        atomicBombBox.
		                        wormholeEffectBox.
		                        hyperjumpBox.
		                        cardGiverBox }.
	self
		should: [ 
			(BoxesGenerator generate: 100 for: effectsDistributions)
				boxSequence ]
		raise: Error
		withMessage: 'Distributions sum must be 100'
]
