Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Card >> applyTo: target over:aCardEffect [

	self subclassResponsibility.
]

{ #category : #operations }
Card >> isPermanent [

	self subclassResponsibility.
]
