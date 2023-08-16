Class {
	#name : #NoEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NoEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) move: aSpaceship to: 0
]
