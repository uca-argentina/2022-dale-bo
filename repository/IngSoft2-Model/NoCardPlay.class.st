Class {
	#name : #NoCardPlay,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
NoCardPlay >> cardType [
	 
		^Error signal: 'There are no cards played'
]
