Class {
	#name : #SpaceshipHand,
	#superclass : #Object,
	#instVars : [
		'hand',
		'name',
		'effectsOnMe'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipHand class >> with: aCollectionOfCards for:aSpaceship [
	^self new initializeWith:aCollectionOfCards for:aSpaceship.
]

{ #category : #accessing }
SpaceshipHand >> addEffectFrom: aCard [
	effectsOnMe add: aCard.
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

{ #category : #accessing }
SpaceshipHand >> effectsOnMe [

	^ effectsOnMe
]

{ #category : #initialization }
SpaceshipHand >> initializeWith: aCollectionOfCards for:aSpaceship [
	hand:= aCollectionOfCards.
	effectsOnMe:=OrderedCollection new.
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

{ #category : #accessing }
SpaceshipHand >> removeEffect:aCardEffect [
	effectsOnMe remove:aCardEffect.
]

{ #category : #accessing }
SpaceshipHand >> removeFromHand:aCard [
	hand remove:aCard.
]

{ #category : #accessing }
SpaceshipHand >> sumOfCardsEffects [

	| cardEffects |
	cardEffects:=effectsOnMe collect:[:card| card effect].
	cardEffects ifNotEmpty:[^cardEffects sum] ifEmpty:[^0] .
]
