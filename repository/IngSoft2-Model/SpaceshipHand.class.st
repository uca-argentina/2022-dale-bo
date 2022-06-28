Class {
	#name : #SpaceshipHand,
	#superclass : #Object,
	#instVars : [
		'hand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipHand class >> with: aCollectionOfCards [
	^self new initializeWith:aCollectionOfCards.
]

{ #category : #initialization }
SpaceshipHand >> assertSpaceshipHas: aCard [

	^ hand
		  detect: [ :each | each className = aCard className ]
		  ifNone: [ Error signal: 'The spaceship does not have this card' ]
]

{ #category : #accessing }
SpaceshipHand >> cards [
	^ hand
]

{ #category : #initialization }
SpaceshipHand >> initializeWith: aCollectionOfCards [
	hand:= aCollectionOfCards.
]

{ #category : #accessing }
SpaceshipHand >> numberOfCards [
	^hand size.
]
