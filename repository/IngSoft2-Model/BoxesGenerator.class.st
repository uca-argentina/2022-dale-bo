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
BoxesGenerator class >> generate: aNumberOfBoxes for: effects with: distributions [
	self assertDistributionsAreValid:distributions.
	^self new initializeWith:aNumberOfBoxes for: effects with: distributions.
]

{ #category : #'instance creation' }
BoxesGenerator class >> generateWithOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes [ 
	^self new initializeWithOnly: anEffect at: aNumberOfBox of:aNumberOfBoxes.
]

{ #category : #action }
BoxesGenerator >> boxSequence [

	^ boxesSequence.
]

{ #category : #accesing }
BoxesGenerator >> boxSequenceInOrder [
	^ boxesSequence.
]

{ #category : #action }
BoxesGenerator >> calculateBoxesFor: effects with: distributions [

	| quantityOfBoxesByEffect boxesOfEffect |
	quantityOfBoxesByEffect := Dictionary new.
	(1 to: effects size by: 1) do: [ :index | 
		boxesOfEffect := (boxes * (distributions at: index)) floor.
		quantityOfBoxesByEffect at: (effects at: index) put: boxesOfEffect ].
	self createBoxesSequenceWith: quantityOfBoxesByEffect
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
	boxesSequence:= boxesSequence shuffled first: boxes
]

{ #category : #actions }
BoxesGenerator >> generateBoxesWithOnly: anEffect at: aBoxNumber [

	[boxesSequence size < boxes] whileTrue: [ 
		((boxesSequence size) == aBoxNumber)
			ifTrue: [ boxesSequence add: anEffect  ]
			ifFalse: [ boxesSequence add:  NoEffectBox new ] ]
]

{ #category : #initialization }
BoxesGenerator >> initializeWith: aNumberOfBoxes for: effects with: distributions [ 
	boxes:= aNumberOfBoxes.
	boxesSequence:= OrderedCollection new.
	self calculateBoxesFor:effects with:distributions.
]

{ #category : #initialization }
BoxesGenerator >> initializeWithOnly: anEffect at: aNumberOfBox of: aNumberOfBoxes [ 
	boxes:= aNumberOfBoxes.
	boxesSequence:= OrderedCollection new.
	self generateBoxesWithOnly:anEffect at: aNumberOfBox 
]
