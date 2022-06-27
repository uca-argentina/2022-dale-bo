Class {
	#name : #WormHoleEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard
		moveBackwards: aSpaceship
		to: 4.
]
