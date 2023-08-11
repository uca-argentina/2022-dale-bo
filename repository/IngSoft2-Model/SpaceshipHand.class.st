Class {
	#name : #SpaceshipHand,
	#superclass : #Object,
	#instVars : [
		'hand',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipHand class >> with: aCollectionOfCards for:aSpaceship [
	^self new initializeWith:aCollectionOfCards for:aSpaceship.
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
SpaceshipHand >> initializeWith: aCollectionOfCards for:aSpaceship [
	hand:= aCollectionOfCards.
	name:= aSpaceship.
]

{ #category : #accessing }
SpaceshipHand >> name [
^name.
]

{ #category : #accessing }
SpaceshipHand >> numberOfCards [
	^hand size.
]

{ #category : #accessing }
SpaceshipHand >> recieveCard:aCard [
	hand add:aCard.
	
]
