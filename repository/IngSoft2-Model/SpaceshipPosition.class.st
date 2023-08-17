Class {
	#name : #SpaceshipPosition,
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
SpaceshipPosition class >> for: aSpaceship at: aBoxNumber distance: aDistance laps: aLapNumber [

	^ self new
		  initialize: aSpaceship
		  at: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber
]

{ #category : #accessing }
SpaceshipPosition >> > anotherPoisiton [
         ^ lapNumber > anotherPoisiton  lapNumber or: [ 
             lapNumber = anotherPoisiton  lapNumber and:
                 boxNumber > anotherPoisiton  boxNumber ] .
]

{ #category : #accessing }
SpaceshipPosition >> boxNumber [
	^ boxNumber
]

{ #category : #accessing }
SpaceshipPosition >> distanceInBox [
	^ distance
]

{ #category : #initialization }
SpaceshipPosition >> initialize: aSpaceship at: aBoxNumber distance: aDistance lap: aLapNumber [
	spaceshipName:= aSpaceship.
	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber := aLapNumber
]

{ #category : #accessing }
SpaceshipPosition >> lapNumber [
	^ lapNumber
]

{ #category : #accessing }
SpaceshipPosition >> name [
	^ spaceshipName
]
