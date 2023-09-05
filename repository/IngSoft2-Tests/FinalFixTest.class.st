Class {
	#name : #FinalFixTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'repeatCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
FinalFixTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
FinalFixTest >> testAGameReturnsPositionOfShipAfterItMoves2 [


	| noEffect boxSequence game |
	die := LoadedDie with: 6.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn2.
	self
		assert: 'Spaceship Alpha'
		isAt: 7
		with: 1
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 1
		with: 1
		in: game
]
