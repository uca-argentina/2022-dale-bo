Class {
	#name : #Distance,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Distance >> amountInParsecs [

	^ self subclassResponsibility
]

{ #category : #accessing }
Distance >> initializeWith: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #actions }
Distance >> negative [

	^ self subclassResponsibility
]
