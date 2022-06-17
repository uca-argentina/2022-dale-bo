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

	(distributions sum) = 100 ifFalse: [ 
		Error signal: 'Distributions sum must be 100' ]
]

{ #category : #'instance creation' }
BoxesGenerator class >> generate: aNumberOfBoxes for: effects with: distributions [

	self assertDistributionsAreValid: distributions.
	^ self new
		  initializeWith: aNumberOfBoxes
		  for: effects
		  with: distributions
]

{ #category : #action }
BoxesGenerator >> boxSequence [

	^ boxesSequence.
]

{ #category : #action }
BoxesGenerator >> calculateBoxesFor: effects with: distributions [

	| quantityOfBoxesByEffect boxesOfEffect |
	quantityOfBoxesByEffect := Dictionary new.
	(1 to: effects size by: 1) do: [ :index | 
		boxesOfEffect := (boxes * ((distributions/100) at: index)) floor.
		self checkIfBoxCanBeCreatedWith:boxesOfEffect.
		quantityOfBoxesByEffect at: (effects at: index) put: boxesOfEffect ].
	self createBoxesSequenceWith: quantityOfBoxesByEffect
]

{ #category : #action }
BoxesGenerator >> checkIfBoxCanBeCreatedWith: boxesOfEffect [

	boxesOfEffect = 0 ifTrue: [ 
		Error signal:
			'Distribution of some boxes does not fit to create at least one box' ]
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

{ #category : #initialization }
BoxesGenerator >> initializeWith: aNumberOfBoxes for: effects with: distributions [

	boxes := aNumberOfBoxes.
	boxesSequence := OrderedCollection new.
	self calculateBoxesFor: effects with: distributions
]
