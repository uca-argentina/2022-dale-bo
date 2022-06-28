Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffect >> triggeredBy: aSpaceship with: aBoard [
 self subclassResponsibility.
]
