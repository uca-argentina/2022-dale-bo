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
	aCard := aCardPlay cardType.
	spaceshipNameThatPlaysCard := aCardPlay playedBy.
	(board spaceshipOf: spaceshipNameThatPlaysCard) hand 
		assertSpaceshipHas: aCard.

	self
		assertValidTurnFor: spaceshipNameThatPlaysCard
		andCardType: aCard.
	self applyToAll: aCard.

	self checkIfIsRedo: aCardPlay.

	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyCancellationBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship |
	(board spaceshipOf:aCardPlay playedBy) hand assertSpaceshipHas:(aCardPlay cardType).
	self
		assertValidTurnFor: aCardPlay playedBy
		andCardType: aCardPlay cardType.
	affectedSpaceship := board spaceshipOf: (aCardPlay target) target.
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship effectsOnMe.
	self assertSpaceship:effectsOnSpaceship hasBeenAffectedBy:aCardPlay target cardType.
	effectsOnSpaceship remove: aCardPlay target cardType.
	board
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with: effectsOnSpaceship).
	self checkIfIsRedo:aCardPlay.
	lastCardPlay := aCardPlay
]

{ #category : #actions }
CardEffectApplicator >> applyEffectBasedOn: aCardPlay [ 
	| affectedSpaceship effectsOnSpaceship |
	(board spaceshipOf:aCardPlay playedBy) hand assertSpaceshipHas:(aCardPlay cardType).
	self assertValidTurnFor:(aCardPlay playedBy) andCardType:(aCardPlay cardType).
	affectedSpaceship := board spaceshipOf: (aCardPlay target).
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship effectsOnMe.
	(effectsOnSpaceship add: aCardPlay cardType).
	board
		updateSpaceshipEffectsOf: affectedSpaceship
		to: (SpaceshipEffects with:
				 effectsOnSpaceship).
	self checkIfIsRedo:aCardPlay.
	lastCardPlay:=aCardPlay.
		
]

{ #category : #actions }
CardEffectApplicator >> applyRedoBasedOn: aCardPlay [

	| redoPlay targetedCard |
	(board spaceshipOf: aCardPlay playedBy) hand assertSpaceshipHas:
		aCardPlay cardType.
	targetedCard := lastCardPlay cardType.
	self assertValidTurnFor: aCardPlay playedBy andCardType: targetedCard.
	targetedCard className = CancellationCard new className
		ifTrue: [ 
			redoPlay := CardPlay
				            by: aCardPlay playedBy
				            card: targetedCard
				            to: (CardPlay
						             by: aCardPlay playedBy
						             card: lastCardPlay target cardType
						             to: aCardPlay target
						             itsRedo: true)
				            itsRedo: true ]
		ifFalse: [ 
			redoPlay := CardPlay
				            by: aCardPlay playedBy
				            card: targetedCard
				            to: aCardPlay target
				            itsRedo: true ].
	self checkIfIsRedo:aCardPlay.
	targetedCard applyUsing: self basedOn: redoPlay
]

{ #category : #actions }
CardEffectApplicator >> applyRepeatBasedOn: aCardPlay [ 
	|lastBoxEffect |
	(board spaceshipOf:aCardPlay playedBy) hand assertSpaceshipHas:(aCardPlay cardType).
	self assertValidTurnFor:(aCardPlay playedBy) andCardType:(aCardPlay cardType).
	lastBoxEffect := board lastBoxEffect.
	lastBoxEffect triggeredBy: aCardPlay target with: board.
	self checkIfIsRedo:aCardPlay.
	lastCardPlay:= aCardPlay.
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
	aCardPlay isRedo ifFalse:[
	self removeCardFromASpaceshipsHandUsing: aCardPlay].
]

{ #category : #initialization }
CardEffectApplicator >> initializeWith: aBoard and: aTurnSequence [ 
	board:= aBoard.
	lastCardPlay:= NoCardPlay new.
	turnSequence:=aTurnSequence.
]

{ #category : #accessing }
CardEffectApplicator >> lastCardPlayed [
	^lastCardPlay.
]

{ #category : #actions }
CardEffectApplicator >> removeCardFromASpaceshipsHandUsing: aCardPlay [

	| spaceshipOldStatus spaceshipNewHand spaceshipHand |
	spaceshipOldStatus := board spaceshipOf: aCardPlay playedBy.
	spaceshipHand := spaceshipOldStatus hand cards.
	spaceshipHand remove: aCardPlay cardType.
	spaceshipNewHand := SpaceshipHand with: spaceshipHand.
	board
		updateSpaceshipHandOf: spaceshipOldStatus
		with: spaceshipNewHand
]
