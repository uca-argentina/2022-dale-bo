Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'boxNumber',
		'lapNumber',
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> at: aBoxNumber distance: aDistance laps: aLapNumber [

	^ self new
		  initializeAt: aBoxNumber
		  distance: aDistance
		  lap: aLapNumber.
]

{ #category : #accessing }
SpaceshipPosition >> boxNumber [
	^ boxNumber
]

{ #category : #accessing }
SpaceshipPosition >> distance [
	^ distance
]

{ #category : #initialization }
SpaceshipPosition >> initializeAt: aBoxNumber distance: aDistance lap: aLapNumber [

	boxNumber := aBoxNumber.
	distance := aDistance.
	lapNumber := aLapNumber
]

{ #category : #accessing }
SpaceshipPosition >> lapNumber [
	^ lapNumber
]
