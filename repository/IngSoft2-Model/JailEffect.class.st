Class {
	#name : #JailEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
JailEffect >> triggeredBy: aSpaceship with: aGame [

	aGame sendToJail:aSpaceship.
]
