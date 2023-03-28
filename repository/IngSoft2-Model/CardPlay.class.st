Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'affectedSpaceship',
		'playedBy',
		'appliedTo',
		'redo'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlay class >> by: aSpaceship card: aCard to: aTarget itsRedo: isRedo [
	^ self new
		  initializeBy: aSpaceship
		  card: aCard
		  to: aTarget
		itsRedo:isRedo.
]

{ #category : #actions }
CardPlay >> applyUsing: aCardEffectApplicator [

	card applyUsing: aCardEffectApplicator basedOn: self
]

{ #category : #accessing }
CardPlay >> card [

	^ card
]

{ #category : #initialization }
CardPlay >> initializeBy: aSpaceship card: aCard to: anotherSpaceship  itsRedo: isRedo [

	playedBy := aSpaceship.
	card := aCard.
	appliedTo := anotherSpaceship.
	redo:= isRedo.
]

{ #category : #accessing }
CardPlay >> isRedo [
	^redo.
]

{ #category : #accessing }
CardPlay >> playedBy [
	^ playedBy
]

{ #category : #accessing }
CardPlay >> target [

	^ appliedTo
]
