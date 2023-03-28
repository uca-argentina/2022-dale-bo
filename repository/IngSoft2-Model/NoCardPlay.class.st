Class {
	#name : #NoCardPlay,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
NoCardPlay >> card [
	 
		^Error signal: 'There are no cards played'
]
