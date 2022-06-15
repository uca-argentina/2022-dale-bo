Class {
	#name : #Graveyard,
	#superclass : #Object,
	#instVars : [
		'cardsPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Graveyard class >> with:aCollection [
^self new initializeWith:aCollection.
]

{ #category : #actions }
Graveyard >> addCard: aCard to: aSpaceship [ 

	cardsPlayed add: (PlayedCard type:aCard to:aSpaceship).
]

{ #category : #initialization }
Graveyard >> initializeWith:aCollection [
	cardsPlayed := aCollection.
]

{ #category : #accesing }
Graveyard >> lastCardPlayed [
	^cardsPlayed last.
]
