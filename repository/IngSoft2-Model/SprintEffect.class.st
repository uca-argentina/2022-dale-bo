Class {
	#name : #SprintEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SprintEffect >> triggeredBy: aSpaceship with: aGame [

	| spaceshipHand |
	spaceshipHand := (aGame handOf: aSpaceship) cards.
	(aGame board) calculate: aSpaceship newpositionUsing: (spaceshipHand size)
]
