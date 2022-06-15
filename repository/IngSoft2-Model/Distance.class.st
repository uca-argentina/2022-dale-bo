Class {
	#name : #Distance,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Distance >> calculateParsec: aDistance [
^self subclassResponsibility.
]

{ #category : #actions }
Distance >> units [
^self subclassResponsibility.
]
