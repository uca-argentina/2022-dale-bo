Class {
	#name : #SpeedCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedCard >> applyUsing: aCardEffectApplicator [
	aCardEffectApplicator applySpeedCard.
]

{ #category : #accesing }
SpeedCard >> effect [

	^ 1
]

{ #category : #actions }
SpeedCard >> playedOn: aGame by: aSpaceship to: anotherSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             card: self
		             to: anotherSpaceship
		             needsRemove: false.
	self applyStrategyFor: aSpaceship in: aGame using: aCardPlay.
	"aGame applyCardPlayFor: aCardPlay"
]
