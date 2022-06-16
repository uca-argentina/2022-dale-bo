Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'ship',
		'boxNumber',
		'lapNumber',
		'hand',
		'effectsOnMe',
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Spaceship class >> assertShipsNameIsValid:aShip [
	(aShip size  > 1) ifFalse: [ 
		Error signal: 'Ship name must have a name longer than one character']
]

{ #category : #instanceCreation }
Spaceship class >> of: aShip at: aBoxNumber distance: aDistance laps: aLapNumber cards: hand and: effectsApplied [

	self assertShipsNameIsValid: aShip.
	^ self new
		  initializeOf: aShip
		  at: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber
		  cards: hand
		  and: effectsApplied
]

{ #category : #accesing }
Spaceship >> boxNumber [

	^ boxNumber
]

{ #category : #action }
Spaceship >> checkSpaceshipHas: aCard [

	^ hand
		  detect: [ :each | each className = aCard className ]
		  ifNone: [ Error signal: 'The spaceship does not have this card' ]
]

{ #category : #action }
Spaceship >> effectsOnMe [
	^effectsOnMe.
]

{ #category : #action }
Spaceship >> hand [

	^ hand
]

{ #category : #initialization }
Spaceship >> initializeOf: aShip at: aBoxNumber distance: aDistance lap: aLapNumber cards: aHand and: effectsApplied [

	ship := aShip.
	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber:=aLapNumber.
	hand:= aHand.
	effectsOnMe := effectsApplied.
]

{ #category : #action }
Spaceship >> isAffectedBy: aCard [
	effectsOnMe add: aCard.
]

{ #category : #accesing }
Spaceship >> lapNumber [

	^ lapNumber
]

{ #category : #action }
Spaceship >> numberOfCards [
	^hand size.
]

{ #category : #accessing }
Spaceship >> ownerShip [

	^ ship
]

{ #category : #accessing }
Spaceship >> parsecNumber [

	^ distance 
]

{ #category : #action }
Spaceship >> receive: aCard [ 
	hand add: aCard. 
]

{ #category : #action }
Spaceship >> removeEffect: aCardEffect [
	| effectToBeRemoved |
	effectToBeRemoved:=effectsOnMe detect: [ :each | (each className = aCardEffect className)].
	effectsOnMe remove: effectToBeRemoved.
]

{ #category : #actions }
Spaceship >> removeFromHand: aCard [
	hand remove: aCard.
]

{ #category : #accesing }
Spaceship >> sumOfCardsEffects [
	| sum |
	sum:=0.
	effectsOnMe do: [ :each | sum:=sum + each effect].
	 ^sum.
]
