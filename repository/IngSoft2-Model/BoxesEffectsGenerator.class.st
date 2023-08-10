Class {
	#name : #BoxesEffectsGenerator,
	#superclass : #Object,
	#instVars : [
		'boxesSequence',
		'numberOfBoxes'
	],
	#classInstVars : [
		'boxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
BoxesEffectsGenerator class >> assertDistributionsAreValid: distributions [

	(distributions  sum: [:element| element probability]) = 100 ifFalse: [ 
		Error signal: 'Distributions sum must be 100' ]
]

{ #category : #'instance creation - old' }
BoxesEffectsGenerator class >> generate: aNumberOfBoxes for: boxesEffectWithDistribution [
	self assertDistributionsAreValid: boxesEffectWithDistribution.
	^ self new
		  initializeWith: aNumberOfBoxes
		  for: boxesEffectWithDistribution.
]

{ #category : #action }
BoxesEffectsGenerator >> boxSequence [

	^ boxesSequence.
]

{ #category : #private }
BoxesEffectsGenerator >> checkIfBoxCanBeCreatedWith: boxesOfEffect [

	boxesOfEffect = 0 ifTrue: [ 
		Error signal:
			'Distribution of some boxes does not fit to create at least one box' ]
]

{ #category : #private }
BoxesEffectsGenerator >> createBoxesWith: effectsWithDistribution [

	| boxesForAnEffect |
	effectsWithDistribution do: [ :each | 
		boxesForAnEffect := (numberOfBoxes  * (each probability / 100)) floor.
		self checkIfBoxCanBeCreatedWith:boxesForAnEffect.
		boxesForAnEffect timesRepeat: [ boxesSequence add: each box ] ]. 
	boxesSequence := boxesSequence shuffled first: numberOfBoxes 
]

{ #category : #initialization }
BoxesEffectsGenerator >> initializeWith: aNumberOfBoxes for: effectsWithDistribution [
	numberOfBoxes := aNumberOfBoxes.
	boxesSequence := OrderedCollection new.
	self createBoxesWith: effectsWithDistribution
]
