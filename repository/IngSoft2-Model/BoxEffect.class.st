Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
BoxEffect >> changePolarity [
	^ self subclassResponsibility
]

{ #category : #actions }
BoxEffect >> triggeredBy: arg1 with: arg2 [
	^ self subclassResponsibility
]
