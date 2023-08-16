Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> applyUsing: arg1 [ 
	^ self subclassResponsibility
]
