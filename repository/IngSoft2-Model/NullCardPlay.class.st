Class {
	#name : #NullCardPlay,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
NullCardPlay >> card [
	 
		^Error signal: 'There are no cards played'
]
