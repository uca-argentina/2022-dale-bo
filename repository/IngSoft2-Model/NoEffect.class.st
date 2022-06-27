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
		moveForward: aSpaceship
		to: 0.
]
