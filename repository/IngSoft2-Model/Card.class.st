Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Card >> isPermanent [

	self subclassResponsibility.
]

{ #category : #operations }
Card >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	self subclassResponsibility.
]

{ #category : #operations }
Card >> redoUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [

	self subclassResponsibility.
]
