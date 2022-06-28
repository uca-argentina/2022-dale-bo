Class {
	#name : #BoxesGenerator,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'boxesSequence'
	],
	#classInstVars : [
		'boxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
BoxesGenerator class >> assertDistributionsAreValid: distributions [

	| probabilities |
	probabilities:=distributions collect:[:element| element probability].
	(probabilities sum) = 100 ifFalse: [ 
		Error signal: 'Distributions sum must be 100' ]
]

{ #category : #'instance creation - old' }
BoxesGenerator class >> generate: aNumberOfBoxes for: boxesEffectWithDistribution [
	self assertDistributionsAreValid: boxesEffectWithDistribution.
	^ self new
		  initializeWith: aNumberOfBoxes
		  for: boxesEffectWithDistribution.
]

{ #category : #action }
BoxesGenerator >> boxSequence [

	^ boxesSequence.
]

{ #category : #action }
BoxesGenerator >> checkIfBoxCanBeCreatedWith: boxesOfEffect [

	boxesOfEffect = 0 ifTrue: [ 
		Error signal:
			'Distribution of some boxes does not fit to create at least one box' ]
]

{ #category : #actions }
BoxesGenerator >> createBoxesWith: effectsWithDistribution [

	| boxesForAnEffect |
	effectsWithDistribution do: [ :each | 
		boxesForAnEffect := (boxes * (each probability / 100)) floor.
		self checkIfBoxCanBeCreatedWith:boxesForAnEffect.
		boxesForAnEffect timesRepeat: [ boxesSequence add: each box ] ].
	boxesSequence := boxesSequence shuffled first: boxes
]

{ #category : #initialization }
BoxesGenerator >> initializeWith: aNumberOfBoxes for: effectsWithDistribution [
	boxes := aNumberOfBoxes.
	boxesSequence := OrderedCollection new.
	self createBoxesWith: effectsWithDistribution
]
