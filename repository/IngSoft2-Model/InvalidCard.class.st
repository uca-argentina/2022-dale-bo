Class {
	#name : #InvalidCard,
	#superclass : #Card,
	#instVars : [
		'aCardP'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
InvalidCard >> applyStrategyFor: aSpaceship in: aGame using: aCardPlay [

	^Error signal: 'There are no cards played'
]

{ #category : #accessing }
InvalidCard >> applyUsing: aCardEffectApplicator [
		^Error signal: 'There are no cards played'
]

{ #category : #accessing }
InvalidCard >> card [
	 
		^Error signal: 'There are no cards played'
]
