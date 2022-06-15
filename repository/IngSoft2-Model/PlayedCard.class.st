Class {
	#name : #PlayedCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'affectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
PlayedCard class >> type: aCard to: aSpaceship [
	^self new initializeWithType: aCard to:aSpaceship.
]

{ #category : #initialize }
PlayedCard >> affectedSpaceship [
^affectedSpaceship.
]

{ #category : #initialize }
PlayedCard >> card [
^card.
]

{ #category : #initialize }
PlayedCard >> initializeWithType: aCard to: aSpaceship [
	card:= aCard.
	affectedSpaceship:=aSpaceship.
]
