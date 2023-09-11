Class {
	#name : #BoxEffect,
	#superclass : #Object,
	#instVars : [
		'polarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
BoxEffect >> changePolarity [
	polarity := polarity not.
]
