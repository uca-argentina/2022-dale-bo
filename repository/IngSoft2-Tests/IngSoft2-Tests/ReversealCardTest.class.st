Class {
	#name : #ReversealCardTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'reversealCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ReversealCardTest >> testSpaceshipBetaPlaysReversealCardInASpeedupBoxInPositionFiveAndSpaceshipAlphaLandsOnItAndMovesToPositionOne [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: SpeedUpEffect new
		               at: 9.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: dieOne
		        and: deckForGame.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 5
		with: 1
		in: game.
	reversealCard playedOn: game by: 'Spaceship Beta' onBox: 9.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 5
		with: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 5
		with: 1
		in: game.
]
