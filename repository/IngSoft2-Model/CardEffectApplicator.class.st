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
	self assert: aCard canBePlayedBy: spaceshipNameThatPlaysCard.
	self applyToAll: aCard.
	self checkIfIsRedo: aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyCancellationBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship spaceshipNameThatPlaysCard aCard cardPlayToBeRemoved |
	spaceshipNameThatPlaysCard := aCardPlay playedBy.
	aCard := aCardPlay card.
	cardPlayToBeRemoved := aCardPlay target.
	self assert: aCard canBePlayedBy: spaceshipNameThatPlaysCard.
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
	self checkIfIsRedo: aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyEffectBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship |
	self assert: aCardPlay card canBePlayedBy: aCardPlay playedBy.
	affectedSpaceship := board spaceshipOf: aCardPlay target.
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship
		                      effectsOnMe.
	effectsOnSpaceship add: aCardPlay card.
	board
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with: effectsOnSpaceship).
	self checkIfIsRedo: aCardPlay.
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
				            itsRedo: true ]
		ifFalse: [ redoPlay := self createRedoPlay: targetedCard with: aCardPlay ].
	self checkIfIsRedo: aCardPlay.
	targetedCard applyUsing: self basedOn: redoPlay
]

{ #category : #actions }
CardEffectApplicator >> applyRepeatBasedOn: aCardPlay [

	| lastBoxEffect |
	self assert: aCardPlay card canBePlayedBy: aCardPlay playedBy.
	lastBoxEffect := board lastBoxEffect.
	lastBoxEffect triggeredBy: aCardPlay target with: board.
	self checkIfIsRedo: aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyToAll: aCardEffect [

	| effectsOnSpaceship |
	board allSpaceships do: [ :each | 
		effectsOnSpaceship := each effectsOnSpaceship effectsOnMe.
		effectsOnSpaceship add: aCardEffect.
		board
			updateSpaceshipEffectsOf: each
			to: (SpaceshipEffects with: effectsOnSpaceship) ]
]

{ #category : #actions }
CardEffectApplicator >> assert: aCard canBePlayedBy: spaceshipNameThatPlaysCard [

	(board spaceshipOf: spaceshipNameThatPlaysCard) hand 
		assertSpaceshipHas: aCard.

	self
		assertValidTurnFor: spaceshipNameThatPlaysCard
		andCardType: aCard
]

{ #category : #asserting }
CardEffectApplicator >> assertSpaceship: effectsOnSpaceship hasBeenAffectedBy: aCard [

	(effectsOnSpaceship occurrencesOf: aCard) >= 1
		ifTrue: [ ^ true ]
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
CardEffectApplicator >> checkIfIsRedo: aCardPlay [

	aCardPlay isRedo ifFalse: [ 
		self removeCardFromASpaceshipsHandUsing: aCardPlay ]
]

{ #category : #actions }
CardEffectApplicator >> createRedoPlay: targetedCard with: aCardPlay [

	^ CardPlay
		  by: aCardPlay playedBy
		  card: targetedCard
		  to: aCardPlay target
		  itsRedo: true
]

{ #category : #initialization }
CardEffectApplicator >> initializeWith: aBoard and: aTurnSequence [ 
	board:= aBoard.
	lastCardPlay:= NullCardPlay new.
	turnSequence:=aTurnSequence.
]

{ #category : #actions }
CardEffectApplicator >> removeCardFromASpaceshipsHandUsing: aCardPlay [

	| spaceshipOldStatus spaceshipNewHand spaceshipHand |
	spaceshipOldStatus := board spaceshipOf: aCardPlay playedBy.
	spaceshipHand := spaceshipOldStatus hand cards.
	spaceshipHand remove: aCardPlay card.
	spaceshipNewHand := SpaceshipHand with: spaceshipHand.
	board
		updateSpaceshipHandOf: spaceshipOldStatus
		with: spaceshipNewHand
]
