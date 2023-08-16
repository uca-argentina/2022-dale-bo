Class {
	#name : #InvalidCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
InvalidCard >> applyUsing: aCardEffectApplicator [
		^Error signal: 'There are no cards played'
]

{ #category : #accessing }
InvalidCard >> card [
	 
		^Error signal: 'There are no cards played'
]
