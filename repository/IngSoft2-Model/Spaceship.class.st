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
Spaceship class >> of: aShip at: aBoxNumber distance: aDistance laps: aLapNumber and: hand [

	self assertShipsNameIsValid: aShip.
	^ self new
		  initializeOf: aShip
		  at: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber
		and:hand.
]

{ #category : #accesing }
Spaceship >> boxNumber [

	^ boxNumber
]

{ #category : #action }
Spaceship >> hand [

	^ hand
]

{ #category : #initialization }
Spaceship >> initializeOf: aShip at: aBoxNumber distance: aDistance lap: aLapNumber and: aHand [

	ship := aShip.
	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber:=aLapNumber.
	hand:= aHand.
	effectsOnMe := OrderedCollection new.
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
Spaceship >> playACard: aCard to: target [
	|card |
	card := hand 
        detect: [ :each | (each type) = (aCard type) ]
        ifNone: [ Error
                signal: 'The spaceship does not have this card' ].
	aCard applyTo: target.
	hand remove: card.
]

{ #category : #action }
Spaceship >> receive: aCard [ 
	hand add: aCard. 
]

{ #category : #accesing }
Spaceship >> sumOfCardsEffects [
	| sum |
	sum:=0.
	effectsOnMe do: [ :each | sum:=sum + each effect].
	 ^sum.
]
