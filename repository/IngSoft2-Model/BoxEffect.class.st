Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffect >> reverse [

	self subclassResponsibility
]

{ #category : #action }
BoxEffect >> triggeredBy: aSpaceship with: aGame [

	self subclassResponsibility
]
