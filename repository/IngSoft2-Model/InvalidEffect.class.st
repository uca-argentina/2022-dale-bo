Class {
	#name : #InvalidEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
InvalidEffect >> reverse [
	"do nothing"
]

{ #category : #action }
InvalidEffect >> triggeredBy: aSpaceship with: aGame [

	^Error signal: 'Game has not started, no spaceship has move yet'
]
