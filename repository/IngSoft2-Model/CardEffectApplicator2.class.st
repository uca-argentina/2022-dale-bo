Class {
	#name : #CardEffectApplicator2,
	#superclass : #Object,
	#instVars : [
		'lastCardPlay',
		'game',
		'cardPlay'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardEffectApplicator2 class >> with: aCardPlay using:aGame [
	^self new initializeWith:aCardPlay and:aGame.
]

{ #category : #actions }
CardEffectApplicator2 >> apply: aCardPlay [ 
	
	aCardPlay applyUsing:self.
]

{ #category : #actions }
CardEffectApplicator2 >> applyAccelerationBasedOn: aCardPlay [

	| aCard spaceshipNameThatPlaysCard |
	aCard := aCardPlay card.
	spaceshipNameThatPlaysCard := aCardPlay playedBy.
	self assertSpaceship: spaceshipNameThatPlaysCard has: aCard.
	self applyToAll: aCard.
	self checkIfIsRedo: aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator2 >> applyAccelerationCard [

	| aCard spaceshipNameThatPlaysCard |
	self assertValidTurnFor: cardPlay playedBy.
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	aCard := cardPlay card.
	spaceshipNameThatPlaysCard := cardPlay playedBy.
	self applyToAll: aCard.
	"self checkIfIsRedo: cardPlay."
	game updateLastCardPlayed: cardPlay card.
	(game handOf: cardPlay playedBy) removeFromHand: cardPlay card
]

{ #category : #actions }
CardEffectApplicator2 >> applyCancellationBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship spaceshipNameThatPlaysCard aCard cardPlayToBeRemoved board |
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
	self checkIfIsRedo: aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator2 >> applyEffectBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship board |
	self assertSpaceship: aCardPlay playedBy has: aCardPlay card.
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
CardEffectApplicator2 >> applyOverloadCard [

	| affectedSpaceship |
	self assertValidTurnFor: cardPlay playedBy.
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	affectedSpaceship := game handOf: cardPlay target.
	affectedSpaceship addEffectFrom: cardPlay card.
	game updateLastCardPlayed: cardPlay card.
	(game handOf: cardPlay playedBy) removeFromHand: cardPlay card
]

{ #category : #actions }
CardEffectApplicator2 >> applyRedoBasedOn: aCardPlay [

	| redoPlay targetedCard board|
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
CardEffectApplicator2 >> applyRedoCard [

	| newCardPlay |
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	newCardPlay := CardPlay by: (cardPlay playedBy) card:(game lastCardPlayed )  to:(cardPlay target)  itsRedo:false.
	game applyCardPlayFor: newCardPlay.
	(game handOf: cardPlay playedBy) removeFromHand: cardPlay card.
]

{ #category : #actions }
CardEffectApplicator2 >> applyRepeatBasedOn: aCardPlay [

	| lastBoxEffect board |
	self assertSpaceship: aCardPlay playedBy has: aCardPlay card.
	lastBoxEffect := board lastBoxEffect.
	lastBoxEffect triggeredBy: aCardPlay target with: board.
	self checkIfIsRedo: aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator2 >> applyRepeatCard [

	| lastBoxEffect |
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	lastBoxEffect := game lastBoxEffect.
	lastBoxEffect triggeredBy: cardPlay target with: game.
	game updateLastCardPlayed: cardPlay card.
   (game handOf: cardPlay playedBy) removeFromHand: cardPlay card .
]

{ #category : #actions }
CardEffectApplicator2 >> applySpeedCard [

	| affectedSpaceship |
	self assertValidTurnFor: cardPlay playedBy.
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	affectedSpaceship := game handOf: cardPlay target.
	affectedSpaceship addEffectFrom: cardPlay card.
	game updateLastCardPlayed: cardPlay card.
	(game handOf: cardPlay playedBy) removeFromHand: cardPlay card
]

{ #category : #private }
CardEffectApplicator2 >> applyToAll: aCardEffect [

	| effectsOnSpaceship |
	game allSpaceshipsHands do: [ :each | 
		effectsOnSpaceship := each effectsOnMe.
		effectsOnSpaceship add: aCardEffect. ]
]

{ #category : #private }
CardEffectApplicator2 >> assertSpaceship: spaceshipNameThatPlaysCard has: aCard [

	(game handOf: spaceshipNameThatPlaysCard ) 
		assertSpaceshipHas: aCard.
]

{ #category : #asserting }
CardEffectApplicator2 >> assertSpaceship: effectsOnSpaceship hasBeenAffectedBy: aCard [

	(effectsOnSpaceship occurrencesOf: aCard) >= 1
		ifFalse: [ Error signal: 'The spaceship does not have this effect applied on' ]
]

{ #category : #actions }
CardEffectApplicator2 >> assertValidTurnFor: aSpaceship [

	(game turnSequence) assertSpaceshipTurn: aSpaceship.
]

{ #category : #actions }
CardEffectApplicator2 >> assertValidTurnFor: aSpaceship andCardType: aCard [

	| whoWantsToPlay board turnSequence|
	whoWantsToPlay := board spaceshipOf: aSpaceship.
	(turnSequence whoPlays ~= whoWantsToPlay name and:
		 aCard isPermanent) ifTrue: [ 
		Error signal:
			'A permanent card cannot be played on another spaceship turn' ].
]

{ #category : #actions }
CardEffectApplicator2 >> checkIfIsRedo: aCardPlay [

	aCardPlay isRedo ifFalse: [ 
		self removeCardOf: aCardPlay ]
]

{ #category : #actions }
CardEffectApplicator2 >> createRedoPlay: targetedCard with: aCardPlay [

	^ CardPlay
		  by: aCardPlay playedBy
		  card: targetedCard
		  to: aCardPlay target
		  itsRedo: true
]

{ #category : #actions }
CardEffectApplicator2 >> execute [ 
	
	cardPlay applyUsing:self.
]

{ #category : #initialization }
CardEffectApplicator2 >> initializeWith: aCardPlay and: aGame [ 
	game:= aGame.
	cardPlay:= aCardPlay.
	lastCardPlay:= InvalidCardPlay new.
]

{ #category : #actions }
CardEffectApplicator2 >> removeCardOf: aCardPlay [
|board|
	board remove: aCardPlay card from:aCardPlay playedBy .
]
