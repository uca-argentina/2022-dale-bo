Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> assertCollectionOfCardsIsValid: aCollectionOfCards [
	(aCollectionOfCards size) > 0 ifFalse: [ Error signal: 'A deck must have at least one card' ].
]

{ #category : #'instance creation' }
Deck class >> with: aCollectionOfCards [

	self assertCollectionOfCardsIsValid: aCollectionOfCards.
	^ self new initializeWith: aCollectionOfCards
]

{ #category : #action }
Deck >> giveCard [

	^ cards atRandom
]

{ #category : #initialization }
Deck >> initializeWith: aCollectionOfCards [

	cards := aCollectionOfCards
]
