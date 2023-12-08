Class {
	#name : #WormHoleEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
WormHoleEffect >> initialize [
	
	retroPositions := -4.
]

{ #category : #action }
WormHoleEffect >> reverse [
	retroPositions := retroPositions negated.
]

{ #category : #action }
WormHoleEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: retroPositions 
]
