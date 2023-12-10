Class {
	#name : #WormHoleEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
WormHoleEffect >> initialize [

	state := NormalWormholeState new.
]

{ #category : #action }
WormHoleEffect >> reverse [
	state := state reverse.
	"retroPositions := retroPositions negated."
]

{ #category : #action }
WormHoleEffect >> triggeredBy: aSpaceship with: aGame [

	state triggeredBy: aSpaceship  with: aGame
]
