Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
GameTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	^ (aGame spaceshipOf: aSpaceshipName) position boxNumber
	  = aPositionNumber
]

{ #category : #tests }
GameTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced.
	^ boxSequence
]

{ #category : #asserting }
GameTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
GameTest >> testAGameCannotBePlayedAfterItHasFinished [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert:'Valen' isAt:13 with:2 in:game.
	self
		should: [ game playATurn ]
		raise: Error
		withMessage: 'Turn cannot be played, game has finished'
]

{ #category : #tests }
GameTest >> testAGameDoesNotHaveAWinnerBecauseIsNotFinished [

	| die game boxSequence |
	die := Die with: 6.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	self
		should: [ game winner ]
		raise: Error
		withMessage:
		'Game does not have a winner beacause is not finished yet'.
]

{ #category : #tests }
GameTest >> testAGameHasABoardWithAAtomicBombInPositionElevenAndTheEffectDoenstChangeLaps [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 13
		               with: AtomicBombEffect new
		               at: 10.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:  'Valen' isAt: 6 with: 1 in: game.
	game playATurn.
	self assert:  'Pablo' isAt: 6 with:1 in:game.
	game playATurn.
	game playATurn.
	self assert:  'Pablo' isAt: 6 with:1 in:game.
	self assert:  'Valen' isAt: 1 with: 1 in: game.
]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipInTheLastPositionOfTheLastLap [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	self deny: game hasFinished.
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: game hasFinished.
	self assert:(game winner) isAt:13 with:2 in:game.
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndValenEndsInPositionOneAndTheOthersInTheSecondPosition [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game rankingOf: 'Valen') equals: 1.
	self assert: (game rankingOf: 'Pablo') equals: 2.
	self assert: (game rankingOf: 'Seba') equals: 2
]

{ #category : #tests }
GameTest >> testAGameIsPlayedWithRandomDiceCupUntilItsFinished [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := Die with: 6.
	dieTwo := Die with: 6.
	dieThree := Die with: 6.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: (game hasFinished) equals:true.
]

{ #category : #tests }
GameTest >> testAGameReturnsPositionOfShipAfterItMoves [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert:'Valen' isAt:13 with:1 in: game.
	self assert:'Pablo' isAt:12 with:1 in: game.
	
]

{ #category : #tests }
GameTest >> testAGameStartsWithShipsAtPositionOne [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	self assert:  'Valen' isAt: 1 with:1 in:game.
]

{ #category : #tests }
GameTest >> testAllPlayersLandInHyperJumpAtBoxFiveAndTheyMoveFirstFiveParsecsAndThenFourAndTheSequenceRestarts [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 9
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 4.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Valen') position) distance equals: 1.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Pablo') position) distance equals: 0.
	game playATurn.
	self assert:'Seba' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Seba')position) distance equals: 1
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithLessThanTwoShips [

	| dieOne dieTwo dieThree aDiceCup boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.


	self
		should: [ 
			SpaceRaceGame
				with: { 'Valen' }
				boardWith: boxSequence
				distance: 200
				laps: 2
				diceCup: aDiceCup
				and: (Deck with: { SpeedCard new }) ]
		raise: Error
		withMessage: 'Game must have more than one Ship'
]

{ #category : #tests }
GameTest >> testValenLandsInAMoonwalkAtBoxSixAndMakeTheOthersGoBackTwoPositions [

	| dieOne dieTwo dieThree game aDiceCup boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (MoonwalkEffect with: 2)
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	game playATurn.
	self assert:'Pablo' isAt:4 with:1 in: game.
	game playATurn.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in: game.
	self assert:'Pablo' isAt:2 with:1 in: game.
	self assert:'Seba' isAt:2 with:1 in: game.
	
]

{ #category : #tests }
GameTest >> testValenLandsInASpeedupBoxInPositionFiveAndMovesToPositionNine [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: SpeedUpEffect new
		               at: 4.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Valen'
		isAt: 9
		with: 1
		in: game
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxSevenAndGoesBackFourBoxesToEndAtBoxNumberThree [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: WormHoleEffect new
		               at: 6.

	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Valen' isAt:3 with:1 in: game.
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxThreeOfLapTwoAndStepBackFourBoxesToEndAtBoxNumberNineAndLapOne [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 9.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 9
		               with: WormHoleEffect new
		               at: 2.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Valen' isAt:9 with:1 in:game.
]
