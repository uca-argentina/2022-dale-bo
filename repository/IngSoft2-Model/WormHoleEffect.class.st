Class {
	#name : #WormHoleEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHoleEffect class >> with:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfParsecs.
]

{ #category : #action }
WormHoleEffect >> applyTo: ships triggeredBy: aShip with: endPosition distance: aDistance and: laps [
 ships
		moveBackwards: aShip
		to: self numberOfBoxesAffectedByWormhole
		with: endPosition
		and: laps
]

{ #category : #action }
WormHoleEffect >> initializeWith: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]

{ #category : #action }
WormHoleEffect >> numberOfBoxesAffectedByWormhole [

	^ 4
]
