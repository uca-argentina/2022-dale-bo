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
WormHoleEffect >> applyTo: spaceships triggeredBy: aSpaceship with: aBoard [

	aBoard
		moveBackwards: aSpaceship
		to: 4.
]

{ #category : #action }
WormHoleEffect >> applyTo: spaceships triggeredBy: aSpaceship with: endPosition distance: aDistance laps: laps [

	spaceships
		moveBackwards: aSpaceship
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
