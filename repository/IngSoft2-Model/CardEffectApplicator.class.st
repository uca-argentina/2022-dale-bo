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
CardEffectApplicator class >> with: aBoard [ 
	^self new initializeWith:aBoard.
]

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
	| effectsOnSpaceship |
	(board spaceshipOf:aCardPlay playedBy) hand assertSpaceshipHas:(aCardPlay cardType).
	self assertValidTurnFor:(aCardPlay playedBy) andCardType:(aCardPlay cardType).
	board allSpaceships do: [ :each | 
		effectsOnSpaceship := each effectsOnSpaceship effectsOnMe.
		effectsOnSpaceship add: aCardPlay cardType.
		board updateSpaceshipEffectsOf: each to: (SpaceshipEffects with:
				  (effectsOnSpaceship) ) ].
	
	self checkIfIsRedo:aCardPlay.
	
	lastCardPlay:=aCardPlay.
]

{ #category : #actions }
CardEffectApplicator >> applyCancellationBasedOn: aCardPlay [

	| affectedSpaceship effectsOnSpaceship |
	(board spaceshipOf:aCardPlay playedBy) hand assertSpaceshipHas:(aCardPlay cardType).
	self
		assertValidTurnFor: aCardPlay playedBy
		andCardType: aCardPlay cardType.
	self assertThereIsACardPlayed.
	affectedSpaceship := board spaceshipOf: aCardPlay appliedTo appliedTo.
	effectsOnSpaceship := affectedSpaceship effectsOnSpaceship
		                      effectsOnMe.
	effectsOnSpaceship remove: aCardPlay appliedTo cardType.
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
	affectedSpaceship := board spaceshipOf: (aCardPlay appliedTo).
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
	self assertThereIsACardPlayed.
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
						             card: lastCardPlay appliedTo cardType
						             to: aCardPlay appliedTo
						             itsRedo: true)
				            itsRedo: true ]
		ifFalse: [ 
			redoPlay := CardPlay
				            by: aCardPlay playedBy
				            card: targetedCard
				            to: aCardPlay appliedTo
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
	lastBoxEffect triggeredBy: aCardPlay playedBy with: board.
	self checkIfIsRedo:aCardPlay.
	lastCardPlay:= aCardPlay.
]

{ #category : #accessing }
CardEffectApplicator >> assertThereIsACardPlayed [

	lastCardPlay ifNil: [ 
		Error signal: 'There are no cards played' ]
]

{ #category : #actions }
CardEffectApplicator >> assertValidTurnFor: aSpaceship andCardType: aCard [

	| whoWantsToPlay |
	whoWantsToPlay := board spaceshipOf: aSpaceship.
	(turnSequence whoPlays ~= whoWantsToPlay nameOfSpaceship and:
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
CardEffectApplicator >> initializeWith: aBoard [ 
	board:= aBoard.
	lastCardPlay:= nil.
]

{ #category : #initialization }
CardEffectApplicator >> initializeWith: aBoard and: aTurnSequence [ 
	board:= aBoard.
	lastCardPlay:= nil.
	turnSequence:=aTurnSequence.
]

{ #category : #accessing }
CardEffectApplicator >> lastCardPlayed [
	^lastCardPlay.
]

{ #category : #actions }
CardEffectApplicator >> removeCardFromASpaceshipsHandUsing: aCardPlay [
| spaceshipOldStatus spaceshipNewHand spaceshipHand |
	spaceshipOldStatus:= (board spaceshipOf:(aCardPlay playedBy)).
	spaceshipHand:=(spaceshipOldStatus hand) hand.
	spaceshipHand remove:(aCardPlay cardType).
	spaceshipNewHand:= SpaceshipHand with: (spaceshipHand).
	board updateSpaceshipHandOf:spaceshipOldStatus with:spaceshipNewHand.
]
