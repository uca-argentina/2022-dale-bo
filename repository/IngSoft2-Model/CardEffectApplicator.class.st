Class {
	#name : #CardEffectApplicator,
	#superclass : #Object,
	#instVars : [
		'board',
		'lastCardPlay'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardEffectApplicator class >> with: aBoard [ 
	^self new initializeWith:aBoard.
]

{ #category : #actions }
CardEffectApplicator >> apply: aCardPlay [ 
	
	aCardPlay applyUsing:self.
]

{ #category : #actions }
CardEffectApplicator >> apply: aCardPlay using: aBoard [

	aCardPlay appliedTo = 'all'
		ifTrue: [ self applyToAllUsing: aBoard with: aCardPlay ]
		ifFalse: [ self applyToASpaceshipUsing: aBoard with: aCardPlay ]
]

{ #category : #actions }
CardEffectApplicator >> applyAccelerationBasedOn: aCardPlay [ 
	| effectsOnSpaceship |
	board allSpaceships do: [ :each | 
		effectsOnSpaceship := each effectsOnSpaceship effectsOnMe.
		effectsOnSpaceship add: aCardPlay cardType.
		board updateSpaceshipEffectsOf: each to: (SpaceshipEffects with:
				  (effectsOnSpaceship) ) ].
	lastCardPlay:=aCardPlay.
]

{ #category : #actions }
CardEffectApplicator >> applyEffectBasedOn: aCardPlay [ 
	| affectedSpaceship effectsOnSpaceship |
	affectedSpaceship := board spaceshipOf: (aCardPlay appliedTo).
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship effectsOnMe.
	(effectsOnSpaceship add: aCardPlay cardType).
	board
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with:
				 effectsOnSpaceship).
	lastCardPlay:=aCardPlay.
		
]

{ #category : #actions }
CardEffectApplicator >> applyRedoBasedOn: aCardPlay [ 
	| targetedCard |
	targetedCard := aCardPlay targetedCard cardType.
	targetedCard = CancellationCard
		ifTrue: [ self cancel: aCardPlay targetedCard using: board ]
		ifFalse: [ self apply: aCardPlay targetedCard using: board ]
]

{ #category : #actions }
CardEffectApplicator >> applyToASpaceshipUsing: aBoard with: aCardPlay [

	| affectedSpaceship effectsOnSpaceship |
	affectedSpaceship := aBoard spaceshipOf: (aCardPlay appliedTo).
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship effectsOnMe.
	(effectsOnSpaceship add: aCardPlay cardType).
	aBoard
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with:
				 effectsOnSpaceship)
]

{ #category : #actions }
CardEffectApplicator >> applyToAllUsing: aBoard with: aCardPlay [

	| effectsOnSpaceship |
	aBoard allSpaceships do: [ :each | 
		effectsOnSpaceship := each effectsOnSpaceship effectsOnMe.
		effectsOnSpaceship add: aCardPlay cardType.
		aBoard updateSpaceshipEffectsOf: each to: (SpaceshipEffects with:
				  (effectsOnSpaceship) ) ]
]

{ #category : #actions }
CardEffectApplicator >> cancel: aCardPlay using: aBoard [ 
	| affectedSpaceship effectsOnSpaceship |
	affectedSpaceship := aBoard spaceshipOf: (aCardPlay appliedTo).
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship effectsOnMe.
	(effectsOnSpaceship remove: aCardPlay targetedCard).
	aBoard
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with:
				 effectsOnSpaceship)
]

{ #category : #initialization }
CardEffectApplicator >> initializeWith: aBoard [ 
	board:= aBoard.
]

{ #category : #accessing }
CardEffectApplicator >> lastCardPlayed [
	^lastCardPlay.
]

{ #category : #actions }
CardEffectApplicator >> redo: aCardPlay using: aBoard [

	| targetedCard |
	targetedCard := aCardPlay targetedCard cardType.
	targetedCard = CancellationCard
		ifTrue: [ self cancel: aCardPlay targetedCard using: aBoard ]
		ifFalse: [ self apply: aCardPlay targetedCard using: aBoard ]
]

{ #category : #actions }
CardEffectApplicator >> repeat: aCardPlay using: aBoard [

	|lastBoxEffect |
	lastBoxEffect := aBoard lastBoxEffect.
	lastBoxEffect triggeredBy: aCardPlay playedBy with: aBoard.
]
