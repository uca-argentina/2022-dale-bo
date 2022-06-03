Class {
	#name : #BoxesGenerator,
	#superclass : #Object,
	#instVars : [
		'parsecPerBox',
		'boxes',
		'boxesSequence',
		'boxesDistribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoxesGenerator class >> generateWith: numberOfBoxes and: numberOfParsecs [
	^self new initializeWith:numberOfBoxes and:numberOfParsecs.
]

{ #category : #instanceCreation }
BoxesGenerator class >> generateWith: numberOfBoxes distance: aDistance distribution: aBoxDistribution [
	^self new initializeWith: numberOfBoxes distance: aDistance distribution: aBoxDistribution.
	
]

{ #category : #'class initialization' }
BoxesGenerator class >> generateWithNoEffectsOf: aNumberOfBoxes [
	^self new initializeWithAllNoEffectsOf: aNumberOfBoxes.
]

{ #category : #'instance creation' }
BoxesGenerator class >> generateWithOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes [ 
	^self new initializeWithOnly: anEffect at: aNumberOfBox of:aNumberOfBoxes.
]

{ #category : #action }
BoxesGenerator >> boxSequence [

	^ boxesSequence
]

{ #category : #action }
BoxesGenerator >> boxes [

	^ boxes
]

{ #category : #action }
BoxesGenerator >> createBoxesSequenceWith: quantityOfBoxesByEffect [

	| i |
	i := 1.
	quantityOfBoxesByEffect do: [ :each | 
		[ each >= i ] whileTrue: [ 
			boxesSequence add: (quantityOfBoxesByEffect keyAtValue: each).
			i := i + 1 ].
		each >= i ifFalse: [ i := 1 ] ].
	boxesSequence := boxesSequence shuffled first: boxes
]

{ #category : #action }
BoxesGenerator >> generateBoxes [

	| wormholeBoxes atomicBombBoxes moonWalkBoxes speedUpBoxes hyperjumpBoxes noEffectBoxes quantityOfBoxesByEffect |
	wormholeBoxes := (boxes * 0.02) floor.
	atomicBombBoxes := (boxes * 0.02) floor.
	moonWalkBoxes := (boxes * 0.1) floor.
	speedUpBoxes := (boxes * 0.2) floor.
	hyperjumpBoxes := (boxes * 0.08) floor.
	noEffectBoxes := boxes - wormholeBoxes - atomicBombBoxes
	                 - moonWalkBoxes - hyperjumpBoxes - speedUpBoxes.
	quantityOfBoxesByEffect := Dictionary newFrom: { 
			                           ((WormHoleEffect with: parsecPerBox)
			                            -> wormholeBoxes).
			                           ((AtomicBombEffect with: parsecPerBox)
			                            -> atomicBombBoxes).
			                           ((MoonwalkEffect
				                             with:
				                             (0 to: (boxes // 7) floor) atRandom
				                             and: parsecPerBox) -> moonWalkBoxes).
			                           ((SpeedUpEffect with: parsecPerBox)
			                            -> speedUpBoxes).
			                           ((HyperJumpEffect
				                             with: { 5. 4. 3. 2. 1 }
				                             parsecs: parsecPerBox)
			                            -> hyperjumpBoxes).
			                           ((NoEffectBox distance: parsecPerBox)
			                            -> noEffectBoxes) }.
	self createBoxesSequenceWith: quantityOfBoxesByEffect
]

{ #category : #actions }
BoxesGenerator >> generateBoxesAllNoEffect [
	| quantityOfBoxesByEffect |
	quantityOfBoxesByEffect := Dictionary newFrom: { 		                          
			                           ((NoEffectBox distance: parsecPerBox)
			                            -> boxes) }.
	self createBoxesSequenceWith: quantityOfBoxesByEffect
]

{ #category : #actions }
BoxesGenerator >> generateBoxesWithOnly: anEffect at: aBoxNumber [

	| noEffectBox |
	noEffectBox:=NoEffectBox distance: parsecPerBox.
	[boxesSequence size < boxes] whileTrue: [ 
		((boxesSequence size) == aBoxNumber)
			ifTrue: [ boxesSequence add: anEffect ]
			ifFalse: [ boxesSequence add: noEffectBox ] ]
]

{ #category : #initialization }
BoxesGenerator >> initializeWith: numberOfBoxes and: numberOfParsecs [

	parsecPerBox := numberOfParsecs // numberOfBoxes.
	boxes := numberOfBoxes.
	boxesSequence := OrderedCollection new.
	self generateBoxes
]

{ #category : #initialize }
BoxesGenerator >> initializeWith: numberOfBoxes distance: aDistance distribution: aBoxDistribution [
	parsecPerBox:= aDistance // numberOfBoxes.
	boxes:= numberOfBoxes.
	boxesSequence:= OrderedCollection new.
	boxesDistribution:= aBoxDistribution.
	self generateBoxes
]

{ #category : #initialization }
BoxesGenerator >> initializeWithAllNoEffectsOf: aNumberOfBoxes [
	boxes:= aNumberOfBoxes.
	boxesSequence:= OrderedCollection new.
	self generateBoxesAllNoEffect
]

{ #category : #initialization }
BoxesGenerator >> initializeWithOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes [ 
	boxes:= aNumberOfBoxes.
	boxesSequence:= OrderedCollection new.
	self generateBoxesWithOnly:anEffect at: aNumberOfBox 
]
