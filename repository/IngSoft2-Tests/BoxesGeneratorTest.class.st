Class {
	#name : #BoxesGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'noEffect',
		'speedUpEffect',
		'moonwalkEffect',
		'hyperjumpEffect',
		'wormholeEffect',
		'deck',
		'cardGiverEffect',
		'atomicBombEffect'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoxesGeneratorTest >> assert: aBoxSequence has: aCertainAmount occurrencesOf: aBoxEffect [ 

	| totalBoxesOfEffect |
	totalBoxesOfEffect:= aBoxSequence count: [ :boxEffect | boxEffect = aBoxEffect  ].
	self assert:totalBoxesOfEffect equals: aCertainAmount.
	
]

{ #category : #running }
BoxesGeneratorTest >> setUp [
	super setUp.
	deck:= Deck with:{SpeedCard new}.
	noEffect:= NoEffect new.
	speedUpEffect:= SpeedUpEffect new.
	moonwalkEffect:= MoonwalkEffect with:2.
	hyperjumpEffect:= HyperJumpEffect with:{Parsecs with:2 . Lightyear with:12 .}.
	atomicBombEffect:= AtomicBombEffect new.
	wormholeEffect:= WormHoleEffect new.
	cardGiverEffect:= CardGiverEffect with:deck
	
]

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
BoxesGeneratorTest >> testBoxesGeneratorCreatesOneHundredBoxesWithTheIndicatedDistributions [

	| noEffectBox speedUpBox moonwalkBox effectsDistributions boxes atomicBombBox wormholeEffectBox hyperjumpBox cardGiverBox  |
	noEffectBox:=DiscreteProbabilityEvent for:(noEffect) with:30.
	speedUpBox:= DiscreteProbabilityEvent for:(speedUpEffect ) with:20.
	moonwalkBox:= DiscreteProbabilityEvent for:(moonwalkEffect ) with:10.
	atomicBombBox:= DiscreteProbabilityEvent for:(atomicBombEffect) with:2.
	wormholeEffectBox:= DiscreteProbabilityEvent for:(wormholeEffect) with:20.
	hyperjumpBox:= DiscreteProbabilityEvent for:(hyperjumpEffect) with:8.
	cardGiverBox:= DiscreteProbabilityEvent for:(cardGiverEffect) with:10.
	effectsDistributions:= { noEffectBox. speedUpBox. moonwalkBox.atomicBombBox. wormholeEffectBox. hyperjumpBox. cardGiverBox. }.
	boxes:= (BoxesGenerator generate: 100 for: effectsDistributions) boxSequence.
	self assert: boxes size equals:100.
   self assert:boxes has: 8 occurrencesOf:hyperjumpEffect.
	self assert:boxes has: 30 occurrencesOf:noEffect.
	self assert:boxes has: 20 occurrencesOf:speedUpEffect.
	self assert:boxes has: 10 occurrencesOf:moonwalkEffect.
	self assert:boxes has: 2 occurrencesOf:atomicBombEffect.
	self assert:boxes has: 20 occurrencesOf:wormholeEffect.
	self assert:boxes has: 10 occurrencesOf:cardGiverEffect.
	
]

{ #category : #tests }
BoxesGeneratorTest >> testBoxesGeneratorProbabilitiesCantBeLowerThanOneHundred [

	| noEffectBox speedUpBox moonwalkBox effectsDistributions atomicBombBox wormholeEffectBox hyperjumpBox cardGiverBox  |
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
