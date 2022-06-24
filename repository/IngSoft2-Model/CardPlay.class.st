Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'affectedSpaceship',
		'playedBy',
		'appliedTo'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardPlay class >> by:aSpaceship type: aCard to: anotherSpaceship [

	^ self new initializeBy:aSpaceship type:aCard to: anotherSpaceship.
]

{ #category : #'class initialization' }
CardPlay class >> type: aCard to: aSpaceship [

	^ self new initializeWithType: aCard to: aSpaceship
]

{ #category : #initialize }
CardPlay >> affectedSpaceship [

	^ affectedSpaceship
]

{ #category : #initialize }
CardPlay >> card [

	^ card
]

{ #category : #accessing }
CardPlay >> cardType [
	^card.
]

{ #category : #initialization }
CardPlay >> initializeBy: aSpaceship type: aCard to: anotherSpaceship [

	playedBy := aSpaceship.
	card := aCard.
	appliedTo := anotherSpaceship
]

{ #category : #initialize }
CardPlay >> initializeWithType: aCard to: aSpaceship [

	card := aCard.
	affectedSpaceship := aSpaceship
]

{ #category : #accessing }
CardPlay >> playedBy [
	^ playedBy
]
