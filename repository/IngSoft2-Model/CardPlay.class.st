Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'affectedSpaceship',
		'playedBy',
		'appliedTo',
		'targetedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardPlay class >> by: aSpaceship type: aCard to: anotherSpaceship for: anotherCard [

	^ self new
		  initializeBy: aSpaceship
		  type: aCard
		  to: anotherSpaceship
		  for: anotherCard
]

{ #category : #'class initialization' }
CardPlay class >> type: aCard to: aSpaceship [

	^ self new initializeWithType: aCard to: aSpaceship
]

{ #category : #accessing }
CardPlay >> appliedTo [

	^ appliedTo
]

{ #category : #accessing }
CardPlay >> cardType [
	^card.
]

{ #category : #initialization }
CardPlay >> initializeBy: aSpaceship type: aCard to: anotherSpaceship for: anotherCard [

	playedBy := aSpaceship.
	card := aCard.
	appliedTo := anotherSpaceship.
	targetedCard:=anotherCard.
]

{ #category : #accessing }
CardPlay >> playedBy [
	^ playedBy
]

{ #category : #accessing }
CardPlay >> targetedCard [
	^ targetedCard
]
