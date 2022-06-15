Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
RepeatCard >> applyTo: target over:aCardEffect [

]

{ #category : #operations }
RepeatCard >> isPermanent [

	^false.
]

{ #category : #actions }
RepeatCard >> playedUsing: aGame by: aSpaceship to: anotherSpaceship for: aCardEffect [
	| lastBoxEffect |
	lastBoxEffect:=aGame lastBoxEffect.
   aGame checkValidTurn: aSpaceship andCardType: self.
   "lastBoxEffect applyTo: (aGame spaceshipController)  triggeredBy:  anotherSpaceship  with: board lastPosition  distance: board boxesDistance laps: board laps.
	lastCardPlayed := LastPlayedCard type:(SpeedCard new) to:anotherSpaceship. TERMINAR MANANA"
]
