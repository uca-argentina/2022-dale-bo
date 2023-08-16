Class {
	#name : #CardEffectApplicator,
	#superclass : #Object,
	#instVars : [
		'board',
		'lastCardPlay',
		'turnSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardEffectApplicator class >> with: aBoard using:aTurnSequence [
	^self new initializeWith:aBoard and:aTurnSequence.
]

{ #category : #actions }
CardEffectApplicator >> apply: aCardPlay [ 
	
	aCardPlay applyUsing:self.
]

{ #category : #actions }
CardEffectApplicator >> applyAccelerationBasedOn: aCardPlay [

	| aCard spaceshipNameThatPlaysCard |
	aCard := aCardPlay card.
	spaceshipNameThatPlaysCard := aCardPlay playedBy.
	self assertSpaceship: spaceshipNameThatPlaysCard has: aCard.
	self applyToAll: aCard.
	self checkCardNeedsToBeRemoved.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyCancellationBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship spaceshipNameThatPlaysCard aCard cardPlayToBeRemoved |
	spaceshipNameThatPlaysCard := aCardPlay playedBy.
	aCard := aCardPlay card.
	cardPlayToBeRemoved := aCardPlay target.
	self assertSpaceship: spaceshipNameThatPlaysCard has: aCard.
	affectedSpaceship := board spaceshipOf: cardPlayToBeRemoved target.
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship
		                      effectsOnMe.
	self
		assertSpaceship: effectsOnSpaceship
		hasBeenAffectedBy: cardPlayToBeRemoved card.
	effectsOnSpaceship remove: cardPlayToBeRemoved card.
	board
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with: effectsOnSpaceship).
	self checkCardNeedsToBeRemoved.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyEffectBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship |
	self assertSpaceship: aCardPlay playedBy has: aCardPlay card.
	affectedSpaceship := board spaceshipOf: aCardPlay target.
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship
		                      effectsOnMe.
	effectsOnSpaceship add: aCardPlay card.
	board
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with: effectsOnSpaceship).
	self checkCardNeedsToBeRemoved.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyRedoBasedOn: aCardPlay [

	| redoPlay targetedCard |
	targetedCard := lastCardPlay card.
	(board spaceshipOf: aCardPlay playedBy) hand assertSpaceshipHas:
		aCardPlay card.
	self assertValidTurnFor: aCardPlay playedBy andCardType: targetedCard.
	targetedCard className = CancellationCard new className
		ifTrue: [ 
			redoPlay := CardPlay
				            by: aCardPlay playedBy
				            card: targetedCard
				            to:
				            (self
					             createRedoPlay: lastCardPlay target card
					             with: aCardPlay)
				            needsRemove: true ]
		ifFalse: [ 
		redoPlay := self createRedoPlay: targetedCard with: aCardPlay ].
	self checkCardNeedsToBeRemoved.
	targetedCard applyUsing: self basedOn: redoPlay
]

{ #category : #actions }
CardEffectApplicator >> applyRepeatBasedOn: aCardPlay [

	| lastBoxEffect |
	self assertSpaceship: aCardPlay playedBy has: aCardPlay card.
	lastBoxEffect := board lastBoxEffect.
	lastBoxEffect triggeredBy: aCardPlay target with: board.
	self checkCardNeedsToBeRemoved.
	lastCardPlay := aCardPlay
]

{ #category : #private }
CardEffectApplicator >> applyToAll: aCardEffect [

	| effectsOnSpaceship |
	board allSpaceships do: [ :each | 
		effectsOnSpaceship := each effectsOnSpaceship effectsOnMe.
		effectsOnSpaceship add: aCardEffect.
		board
			updateSpaceshipEffectsOf: each
			to: (SpaceshipEffects with: effectsOnSpaceship) ]
]

{ #category : #private }
CardEffectApplicator >> assertSpaceship: spaceshipNameThatPlaysCard has: aCard [

	(board spaceshipOf: spaceshipNameThatPlaysCard) hand 
		assertSpaceshipHas: aCard.

	self
		assertValidTurnFor: spaceshipNameThatPlaysCard
		andCardType: aCard
]

{ #category : #asserting }
CardEffectApplicator >> assertSpaceship: effectsOnSpaceship hasBeenAffectedBy: aCard [

	(effectsOnSpaceship occurrencesOf: aCard) >= 1
		ifFalse: [ Error signal: 'The spaceship does not have this effect applied on' ]
]

{ #category : #actions }
CardEffectApplicator >> assertValidTurnFor: aSpaceship andCardType: aCard [

	| whoWantsToPlay |
	whoWantsToPlay := board spaceshipOf: aSpaceship.
	(turnSequence whoPlays ~= whoWantsToPlay name and:
		 aCard isPermanent) ifTrue: [ 
		Error signal:
			'A permanent card cannot be played on another spaceship turn' ].
]

{ #category : #actions }
CardEffectApplicator >> checkCardNeedsToBeRemoved [

	aCardPlay needsRemove ifFalse: [ self removeCardOf ]
]

{ #category : #actions }
CardEffectApplicator >> createRedoPlay: targetedCard with: aCardPlay [

	^ CardPlay
		  by: aCardPlay playedBy
		  card: targetedCard
		  to: aCardPlay target
		  needsRemove: true
]

{ #category : #initialization }
CardEffectApplicator >> initializeWith: aBoard and: aTurnSequence [ 
	board:= aBoard.
	lastCardPlay:= InvalidCard new.
	turnSequence:=aTurnSequence.
]

{ #category : #actions }
CardEffectApplicator >> removeCardOf [
	board remove: aCardPlay card from:aCardPlay playedBy .
]
