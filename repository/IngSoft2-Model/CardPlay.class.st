Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'affectedSpaceship',
		'playedBy',
		'appliedTo',
		'targetedCard',
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

{ #category : #'class initialization' }
CardPlay class >> by: aSpaceship type: aCard to: anotherSpaceship for: anotherCard [

	^ self new
		  initializeBy: aSpaceship
		  type: aCard
		  to: anotherSpaceship
		  for: anotherCard
		  itsRedo: its
]

{ #category : #'class initialization' }
CardPlay class >> type: aCard to: aSpaceship [

	^ self new initializeWithType: aCard to: aSpaceship
]

{ #category : #accessing }
CardPlay >> appliedTo [

	^ appliedTo
]

{ #category : #actions }
CardPlay >> applyUsing: aCardEffectApplicator [ 
	card applyUsing:aCardEffectApplicator basedOn:self.
]

{ #category : #accessing }
CardPlay >> cardType [
	^card.
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
CardPlay >> targetedCard [
	^ targetedCard
]
