Class {
	#name : #InvalidCardPlay,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
InvalidCardPlay >> card [
	 
		^Error signal: 'There are no cards played'
]
