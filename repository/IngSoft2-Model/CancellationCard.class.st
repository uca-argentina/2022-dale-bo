Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'lastCancelledEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [

	aCardEffectApplicator applyCancellationBasedOn: aCardPlay.
]

{ #category : #operations }
CancellationCard >> isPermanent [

	^false.
]

{ #category : #actions }
CancellationCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship for: aCard [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: (CardPlay
				              by: aSpaceship
				              card: aCard
				              to: anotherSpaceship
				              itsRedo: false)
		             itsRedo: false.
	aGame applyCardPlay: aCardPlay
]
