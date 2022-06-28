Class {
	#name : #SpeedUpEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard
		moveForward: aSpaceship
		to: 4.
]
