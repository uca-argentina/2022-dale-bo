Class {
	#name : #CardEffectApplicator,
	#superclass : #Object,
	#instVars : [
		'game',
		'cardPlay'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardEffectApplicator class >> with: aCardPlay using:aGame [
	^self new initializeWith:aCardPlay and:aGame.
]

{ #category : #actions }
CardEffectApplicator >> apply: aCardPlay [ 
	
	aCardPlay applyUsing:self.
]

{ #category : #actions }
CardEffectApplicator >> applyAccelerationCard [

	| aCard spaceshipNameThatPlaysCard |
	"self assertValidTurnFor: cardPlay playedBy."
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	aCard := cardPlay card.
	spaceshipNameThatPlaysCard := cardPlay playedBy.
	self applyToAll: aCard.
	"self checkIfIsRedo: cardPlay."
	game updateLastCardPlayed: cardPlay card.
	self checkCardNeedsToBeRemoved
]

{ #category : #actions }
CardEffectApplicator >> applyCancellationCard [

	| spaceshipsAffected |
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	spaceshipsAffected:= game allSpaceshipsHands select: [ :each | (each effectsOnMe) includes:(cardPlay target) ].
	spaceshipsAffected do: [ :each | each removeEffect: cardPlay target ].
	self checkCardNeedsToBeRemoved
]

{ #category : #actions }
CardEffectApplicator >> applyOverloadCard [

	| affectedSpaceship |
	"self assertValidTurnFor: cardPlay playedBy."
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	affectedSpaceship := game handOf: cardPlay target.
	affectedSpaceship addEffectFrom: cardPlay card.
	game updateLastCardPlayed: cardPlay card.
	self checkCardNeedsToBeRemoved
]

{ #category : #actions }
CardEffectApplicator >> applyRedoCard [

	| newCardPlay |
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	newCardPlay := CardPlay by: (cardPlay playedBy) card:(game lastCardPlayed )  to:(cardPlay target)  needsRemove:true.
	game applyCardPlayFor: newCardPlay.
	self checkCardNeedsToBeRemoved
]

{ #category : #actions }
CardEffectApplicator >> applyRepeatCard [

	| lastBoxEffect |
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	lastBoxEffect := (game board )lastBoxEffect.
	lastBoxEffect triggeredBy: cardPlay target with: game.
	game updateLastCardPlayed: cardPlay card.
	self checkCardNeedsToBeRemoved
]

{ #category : #action }
CardEffectApplicator >> applyReversealCard [
	| boxEffect aPosition|
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	"boxEffect := (game board )lastBoxEffect.
	boxEffect triggeredBy: cardPlay target with: game."
	aPosition := cardPlay target.
	boxEffect := ( game board ) boxAt: aPosition.
	boxEffect reverse.
	game updateLastCardPlayed: cardPlay card.
	self checkCardNeedsToBeRemoved
]

{ #category : #actions }
CardEffectApplicator >> applySpeedCard [

	| affectedSpaceship |
	"self assertValidTurnFor: cardPlay playedBy."
	self assertSpaceship: cardPlay playedBy has: cardPlay card.
	affectedSpaceship := game handOf: cardPlay target.
	affectedSpaceship addEffectFrom: cardPlay card.
	game updateLastCardPlayed: cardPlay card.
	self checkCardNeedsToBeRemoved
]

{ #category : #private }
CardEffectApplicator >> applyToAll: aCardEffect [

	| effectsOnSpaceship |
	game allSpaceshipsHands do: [ :each | 
		effectsOnSpaceship := each effectsOnMe.
		effectsOnSpaceship add: aCardEffect. ]
]

{ #category : #private }
CardEffectApplicator >> assertSpaceship: spaceshipNameThatPlaysCard has: aCard [

	(game handOf: spaceshipNameThatPlaysCard ) 
		assertSpaceshipHas: aCard.
]

{ #category : #actions }
CardEffectApplicator >> checkCardNeedsToBeRemoved [

	cardPlay needsRemove ifFalse: [ (game handOf: cardPlay playedBy) removeFromHand: cardPlay card ]
]

{ #category : #actions }
CardEffectApplicator >> execute [ 
	
	cardPlay applyUsing:self.
]

{ #category : #initialization }
CardEffectApplicator >> initializeWith: aCardPlay and: aGame [ 
	game:= aGame.
	cardPlay:= aCardPlay.
]
