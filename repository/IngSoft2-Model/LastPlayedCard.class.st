Class {
	#name : #LastPlayedCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'affectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
LastPlayedCard class >> type: aCard to: aSpaceship [

	^ self new initializeWithType: aCard to: aSpaceship
]

{ #category : #initialize }
LastPlayedCard >> affectedSpaceship [

	^ affectedSpaceship
]

{ #category : #initialize }
LastPlayedCard >> card [

	^ card
]

{ #category : #initialize }
LastPlayedCard >> initializeWithType: aCard to: aSpaceship [

	card := aCard.
	affectedSpaceship := aSpaceship
]
