Class {
	#name : #WormHoleEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) move: aSpaceship to: -4
]
