Class {
	#name : #InstantCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
InstantCard >> applyStrategyFor: aSpaceship in: aGame using: aCardPlay [

	aGame applyCardPlayFor: aCardPlay
]
