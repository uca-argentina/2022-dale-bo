Class {
	#name : #Lightyear,
	#superclass : #Distance,
	#instVars : [
		'totalParsecDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Lightyear class >> with: aDistance [
	^ self new initializeWith: aDistance.
]

{ #category : #actions }
Lightyear >> calculateParsec: aDistance [
 ^ aDistance/3.
]

{ #category : #initialize }
Lightyear >> initializeWith: aDistance [
	totalParsecDistance := self calculateParsec: aDistance.
]

{ #category : #accesing }
Lightyear >> units [
	^totalParsecDistance.
]
