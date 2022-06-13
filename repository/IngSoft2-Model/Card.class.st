Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Card >> applyTo: target over:aCardEffect [

	self subclassResponsibility.
]

{ #category : #accessing }
Card >> family [
self subclassResponsibility.
]

{ #category : #accessing }
Card >> type [
self subclassResponsibility.
]
