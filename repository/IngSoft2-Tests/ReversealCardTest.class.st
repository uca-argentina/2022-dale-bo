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
ReversealCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber having: aHand in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
	"self assert: aGame handOf: aSpaceshipName equals: aHand."


]

{ #category : #tests }
ReversealCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.


]

{ #category : #tests }
ReversealCardTest >> assert: aSpaceshipName isAtPostion: aPositionNumber with: aLapNumber atDistance: aDistance in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
	self assert: spaceshipPosition distanceInBox equals: aDistance.
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
ReversealCardTest >> testReversealCardIsPlayedToTimesInASpeedupBoxInPositionNineAndSpaceshipAlphaLandsOnItAndMovesToPositionOne [ 

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
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 9.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 13
		with: 1
		in: game.
]

{ #category : #tests }
ReversealCardTest >> testReversealCardIsPlayedTwoTimesInACardGiverBoxInPositionFiveAndSpaceshipBetaLandsOnItAndReceivesACard [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: (CardGiverEffect with: deckForGame)
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
	self assert: (game handOf: 'Spaceship Alpha') cards size equals: 1.
	reversealCard playedOn: game by: 'Spaceship Beta' onBox: 5.
	game playATurn.
	self assert: (game handOf: 'Spaceship Beta') cards size equals: 2.
]

{ #category : #tests }
ReversealCardTest >> testReversealCardIsPlayedTwoTimesInAMoonwalkBoxInFivePosition [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 13
		               with: (MoonwalkEffect with: 3)
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
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 9.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 9
		with: 1
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 2
		with: 1
		in: game.
]

{ #category : #tests }
ReversealCardTest >> testReversealCardIsPlayedTwoTimesInAWormholeBoxInPositionFiveAndSpaceshipAlphaLandsOnItAndMovesToPositionNine [

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
	reversealCard playedOn: game by: 'Spaceship Beta' onBox: 5.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 1
		with: 1
		in: game.
]

{ #category : #tests }
ReversealCardTest >> testSpaceshipAlphaAndBetaPlaysReversealCardInAHyperjumpEffecttBoxInPositionFiveAndSpaceshipBetaGoesToPositionSeven [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: dieOne
		        and: deckForGame.
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 5.
	game playATurn.
	reversealCard playedOn: game by: 'Spaceship Beta' onBox: 5.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
]

{ #category : #tests }
ReversealCardTest >> testSpaceshipAlphaPlaysReversealCardInACardGiverBoxInPositionFiveAndSpaceshipAlphaLandsOnItAndNoCardIsReceived [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: (CardGiverEffect with: deckForGame)
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
	self assert: (game handOf: 'Spaceship Alpha') cards size equals: 1.
]

{ #category : #tests }
ReversealCardTest >> testSpaceshipAlphaPlaysReversealCardInAHyperjumpEffecttBoxInPositionFiveAndSpaceshipAlphaGoesToPositionTwo [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: dieOne
		        and: deckForGame.
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 5.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAtPostion: 2
		with: 1
		atDistance: 1
		in: game.
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
ReversealCardTest >> testSpaceshipBetaPlaysReversealCardInANoEffectBoxInPositionFiveAndEffectDoesNotChange [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: NoEffect new
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
		isAt: 5
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

{ #category : #tests }
ReversealCardTest >> testSpaceshipBetaPlaysReversealCardInAnAtomicBombEffecttBoxInPositionFiveAndAtomicBombEffectIsTheSame [

	| dieOne game boxSequence deckForGame |
	dieOne := LoadedDie with: 4.
	deckForGame := Deck with: { reversealCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: AtomicBombEffect new
		               at: 9.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: dieOne
		        and: deckForGame.
	reversealCard playedOn: game by: 'Spaceship Alpha' onBox: 9.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 5
		with: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 5
		with: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 1
		with: 1
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 1
		with: 1
		in: game.
]
