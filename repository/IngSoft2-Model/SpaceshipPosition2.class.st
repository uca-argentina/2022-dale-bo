Class {
	#name : #SpaceshipPosition2,
	#superclass : #Object,
	#instVars : [
		'boxNumber',
		'lapNumber',
		'distance',
		'spaceshipName'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition2 class >> at: aBoxNumber distance: aDistance laps: aLapNumber [

	^ self new
		  initializeAt: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber.
]

{ #category : #'instance creation' }
SpaceshipPosition2 class >> for: aSpaceship at: aBoxNumber distance: aDistance laps: aLapNumber [

	^ self new
		  initialize: aSpaceship
		  at: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber
]

{ #category : #accessing }
SpaceshipPosition2 >> > anotherPoisiton [
         ^ lapNumber > anotherPoisiton  lapNumber or: [ 
             lapNumber = anotherPoisiton  lapNumber and:
                 boxNumber > anotherPoisiton  boxNumber ] .
]

{ #category : #accessing }
SpaceshipPosition2 >> boxNumber [
	^ boxNumber
]

{ #category : #accessing }
SpaceshipPosition2 >> distanceInBox [
	^ distance
]

{ #category : #initialization }
SpaceshipPosition2 >> initialize: aSpaceship at: aBoxNumber distance: aDistance lap: aLapNumber [
	spaceshipName:= aSpaceship.
	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber := aLapNumber
]

{ #category : #initialization }
SpaceshipPosition2 >> initializeAt: aBoxNumber distance: aDistance lap: aLapNumber [

	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber := aLapNumber
]

{ #category : #accessing }
SpaceshipPosition2 >> lapNumber [
	^ lapNumber
]

{ #category : #accessing }
SpaceshipPosition2 >> name [
	^ spaceshipName
]
