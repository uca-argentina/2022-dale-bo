Class {
	#name : #NoEffectBox,
	#superclass : #BoxEffect,
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
NoEffectBox >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance and: laps [
 ships
		moveForward: aShip
		to: self effect
		with: endPosition
		and: laps
]

{ #category : #action }
NoEffectBox >> effect [

	^ 0
]

{ #category : #initialization }
NoEffectBox >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
