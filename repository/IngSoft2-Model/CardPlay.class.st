Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'playedBy',
		'appliedTo',
		'needsRemove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlay class >> by: aSpaceship card: aCard to: aTarget needsRemove: boolean [

	^ self new
		  initializeBy: aSpaceship
		  card: aCard
		  to: aTarget
		  needsRemove: boolean
]

{ #category : #actions }
CardPlay >> applyUsing: aCardEffectApplicator [

	card applyUsing: aCardEffectApplicator
]

{ #category : #accessing }
CardPlay >> card [

	^ card
]

{ #category : #initialization }
CardPlay >> initializeBy: aSpaceship card: aCard to: anotherSpaceship  needsRemove: boolean [

	playedBy := aSpaceship.
	card := aCard.
	appliedTo := anotherSpaceship.
	needsRemove:= boolean.
]

{ #category : #accessing }
CardPlay >> needsRemove [
	^needsRemove.
]

{ #category : #accessing }
CardPlay >> playedBy [
	^ playedBy
]

{ #category : #accessing }
CardPlay >> target [

	^ appliedTo
]
