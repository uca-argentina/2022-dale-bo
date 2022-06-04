Class {
	#name : #BoxesGenerator,
	#superclass : #Object,
	#instVars : [
		'parsecPerBox',
		'boxes',
		'boxesSequence',
		'boxesDistribution'
	],
	#classInstVars : [
		'boxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
BoxesGenerator class >> assertDistributionsAreValid: distributions [
	distributions sum = 1 ifFalse: [ 
        Error signal: 'Distributions sum must be 1' ].
]

{ #category : #'instance creation' }
BoxesGenerator class >> generate: anInteger distance: anInteger2 for: aCollection with: aCollection4 [ 
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
BoxesGenerator class >> generate: aNumberOfBoxes for: effects with: distributions [
	self assertDistributionsAreValid:distributions.
	^self new initializeWith:aNumberOfBoxes for: effects with: distributions.
]

{ #category : #'instance creation' }
BoxesGenerator class >> generateWith: numberOfBoxes and: numberOfParsecs [

	^ self new initializeWith: numberOfBoxes
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

{ #category : #actions }
BoxesGenerator >> generateBoxesAllNoEffect [
	| quantityOfBoxesByEffect |
	quantityOfBoxesByEffect := Dictionary newFrom: { 		                          
			                           ((NoEffectBox distance: parsecPerBox)
			                            -> boxes) }.
	self createBoxesSequenceWith: quantityOfBoxesByEffect
]

{ #category : #action }
BoxesGenerator >> generateBoxesWith: effects and: distributions [

	| quantityOfBoxesByEffect boxesOfEffect |
	quantityOfBoxesByEffect := Dictionary new.
	(1 to: effects size by: 1) do: [ :index | 
		boxesOfEffect := (boxes * (distributions at: index)) floor.
		quantityOfBoxesByEffect at: (self initializeEffect:(effects at: index)) put: boxesOfEffect ].
	self createBoxesSequenceWith: quantityOfBoxesByEffect
]

{ #category : #actions }
BoxesGenerator >> generateBoxesWithOnly: anEffect at: aBoxNumber [

	[boxesSequence size < boxes] whileTrue: [ 
		((boxesSequence size) == aBoxNumber)
			ifTrue: [ boxesSequence add: (self initializeEffect: anEffect)  ]
			ifFalse: [ boxesSequence add: (self initializeEffect: NoEffectBox) ] ]
]

{ #category : #actions }
BoxesGenerator >> initializeEffect: anEffect [
	(anEffect == MoonwalkEffect ) ifTrue:[^ (MoonwalkEffect with:2)].
	(anEffect == HyperJumpEffect ) ifTrue:[^ (HyperJumpEffect with: {5. 4.})].
	((anEffect ~= MoonwalkEffect ) or:(anEffect ~= HyperJumpEffect )) ifTrue:[^ (anEffect new)].
]

{ #category : #initialization }
BoxesGenerator >> initializeWith: numberOfBoxes [

	parsecPerBox := numberOfParsecs // numberOfBoxes.
	boxes := numberOfBoxes.
	boxesSequence := OrderedCollection new.
	self generateBoxesWith: effects and: distributions
]

{ #category : #initialize }
BoxesGenerator >> initializeWith: numberOfBoxes distance: aDistance distribution: aBoxDistribution [

	parsecPerBox := aDistance // numberOfBoxes.
	boxes := numberOfBoxes.
	boxesSequence := OrderedCollection new.
	boxesDistribution := aBoxDistribution.
	self generateBoxesWith: effects and: distributions
]

{ #category : #initialization }
BoxesGenerator >> initializeWith: aNumberOfBoxes for: effects with: distributions [ 
	boxes:= aNumberOfBoxes.
	boxesSequence:= OrderedCollection new.
	self generateBoxesWith:effects and:distributions.
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
