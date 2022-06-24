Class {
	#name : #SpaceshipStatus,
	#superclass : #Object,
	#instVars : [
		'hand',
		'effectsOnMe',
		'name',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipStatus class >> of: aSpaceshipName position: aSpaceshipPosition cards: aSpaceshipHand effects: aSpaceshipEffects [

	^ self new
		  initializeOf: aSpaceshipName
		  atPosition: aSpaceshipPosition
		  cards: aSpaceshipHand
		  andEffects: aSpaceshipEffects.
]

{ #category : #initialization }
SpaceshipStatus >> effectsOnSpaceship [

	^ effectsOnMe
]

{ #category : #accessing }
SpaceshipStatus >> hand [
	^ hand
]

{ #category : #initialization }
SpaceshipStatus >> initializeOf: aSpaceshipName atPosition: aSpaceshipPosition cards: aSpaceshipHand andEffects: aSpaceshipEffects [

	name := aSpaceshipName.
	position := aSpaceshipPosition.
	hand := aSpaceshipHand.
	effectsOnMe := aSpaceshipEffects
]

{ #category : #accessing }
SpaceshipStatus >> name [
	^ name
]

{ #category : #initialization }
SpaceshipStatus >> nameOfSpaceship [

	^ name
]

{ #category : #accessing }
SpaceshipStatus >> position [
	^ position
]
