Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'boxNumber',
		'lapNumber',
		'hand',
		'effectsOnMe',
		'distance',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Spaceship class >> assertShipsNameIsValid: aSpaceship [

	aSpaceship size > 1 ifFalse: [ 
		Error signal: 'Ship name must have a name longer than one character' ]
]

{ #category : #instanceCreation }
Spaceship class >> of: aSpaceship at: aBoxNumber distance: aDistance laps: aLapNumber cards: spaceshipsHand and: effectsApplied [

	self assertShipsNameIsValid: aSpaceship.
	^ self new
		  initializeOf: aSpaceship
		  at: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber
		  cards: spaceshipsHand
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

{ #category : #accessing }
Spaceship >> distanceInBox [

	^ distance 
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
Spaceship >> initializeOf: aSpaceship at: aBoxNumber distance: aDistance lap: aLapNumber cards: aSpaceshipsHand and: effectsApplied [

	name := aSpaceship.
	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber:=aLapNumber.
	hand:= aSpaceshipsHand.
	effectsOnMe := effectsApplied.
]

{ #category : #action }
Spaceship >> isAffectedBy: aCard [

	effectsOnMe add: aCard
]

{ #category : #accesing }
Spaceship >> lapNumber [

	^ lapNumber
]

{ #category : #accessing }
Spaceship >> nameOfSpaceship [

	^ name
]

{ #category : #action }
Spaceship >> numberOfCards [
	^hand size.
]

{ #category : #action }
Spaceship >> receive: aCard [

	hand add: aCard
]

{ #category : #action }
Spaceship >> removeEffect: aCardEffect [

	| effectToBeRemoved |
	effectToBeRemoved := effectsOnMe detect: [ :each | 
		                     each className = aCardEffect className ].
	effectsOnMe remove: effectToBeRemoved
]

{ #category : #actions }
Spaceship >> removeFromHand: aCard [

	hand remove: aCard
]

{ #category : #accesing }
Spaceship >> sumOfCardsEffects [

	| sum |
	sum := 0.
	effectsOnMe do: [ :each | sum := sum + each effect ].
	^ sum
]
