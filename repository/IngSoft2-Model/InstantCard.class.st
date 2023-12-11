Class {
	#name : #InstantCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
InstantCard >> applyStrategyFor: aSpaceship in: aGame using: aCardPlay [

	aGame applyCardPlayFor: aCardPlay
]
