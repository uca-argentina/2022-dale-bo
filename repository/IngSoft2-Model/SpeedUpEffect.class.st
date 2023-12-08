Class {
	#name : #SpeedUpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'jumpPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpeedUpEffect >> initialize [ 
	super initialize.
	jumpPositions := 4.
]

{ #category : #action }
SpeedUpEffect >> reverse [
	jumpPositions := jumpPositions negated.
]

{ #category : #actions }
SpeedUpEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: 4
]
