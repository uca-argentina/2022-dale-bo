Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffect >> triggeredBy: aSpaceship with: aGame [

	| spaceshipHand |
	spaceshipHand := (aGame handOf: aSpaceship) cards.
	(aGame board) calculate: aSpaceship newpositionUsing: (spaceshipHand size)
]
