Class {
	#name : #NoEffectBox,
	#superclass : #Object,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
NoEffectBox class >> distance: aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
NoEffectBox >> effect [

	^ 0
]

{ #category : #action }
NoEffectBox >> effectTo: ships appliedBy: aShip with: endPosition and: laps [

	ships
		moveForward: aShip
		to: self effect
		with: endPosition
		and: laps
]

{ #category : #initialization }
NoEffectBox >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
