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
ReversealCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.


]

{ #category : #tests }
ReversealCardTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize-1 timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #running }
ReversealCardTest >> setUp [
	super setUp.
	die := LoadedDie with:6.
	reversealCard := ReversealCard new.
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
ReversealCardTest >> testSpaceshipAlphaPlaysReversealCardInAMoonwalkBoxInFivePositionAndSpaceshipAlphaLandsInFivePositionAndAllSpaceshipsMovesToFourPositionExceptSpaceshipAlpha [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 13
		               with: (MoonwalkEffect with: 3)
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta' . 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: dieOne
		        and: deckForGame.	
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 5.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 5
		with: 1
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 4
		with: 1
		in: game.
	self
		assert: 'Spaceship Gamma'
		isAt: 4
		with: 1
		in: game.
]

{ #category : #tests }
ReversealCardTest >> testSpaceshipBetaPlaysReversealCardInASpeedupBoxInPositionFiveAndSpaceshipAlphaLandsOnItAndMovesToPositionOne [ 

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
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

{ #category : #tests }
ReversealCardTest >> testSpaceshipBetaPlaysReversealCardInAWormholeBoxInPositionFiveAndSpaceshipAlphaLandsOnItAndMovesToPositionNine [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: WormHoleEffect new
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: dieOne
		        and: deckForGame.
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 5.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 9
		with: 1
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 1
		with: 1
		in: game.
]
