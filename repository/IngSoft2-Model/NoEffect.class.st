Class {
	#name : #NoEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NoEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard
		move: aSpaceship
		to: 0.
]
