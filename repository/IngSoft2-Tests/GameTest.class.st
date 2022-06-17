Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize timesRepeat: [ boxSequence add: NoEffectBox new ].
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
		                for: { NoEffectBox new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self
		should: [ game playATurn ]
		raise: Error
		withMessage: 'Turn cannot be played, games has finished'
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
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 6.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 6.
	game playATurn.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 1.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 1
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
		                for: { NoEffectBox new }
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
	self assert: (game spaceshipOf: game winner) boxNumber equals: 13.
	self assert: (game spaceshipOf: game winner) lapNumber equals: 2
]

{ #category : #tests }
GameTest >> testAGameHasNoWinnerBeforeItsFinished [

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
		                for: { NoEffectBox new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert: game winner equals: nil
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndValenEndsInLapTwo [

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
		                for: { NoEffectBox new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: (game spaceshipOf: 'Valen') lapNumber equals: 2
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
		                for: { NoEffectBox new }
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
		                for: { NoEffectBox new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 13.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 12
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
		                for: { NoEffectBox new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 1
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
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 7.
	self assert: (game spaceshipOf: 'Valen') distanceInBox equals: 1.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 7.
	self assert: (game spaceshipOf: 'Pablo') distanceInBox equals: 0.
	game playATurn.
	self assert: (game spaceshipOf: 'Seba') boxNumber equals: 7.
	self assert: (game spaceshipOf: 'Seba') distanceInBox equals: 1
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
		                for: { NoEffectBox new }
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
GameTest >> testValenLandsInAMoonwalkAtBoxSevenAndMakeTheOthersGoBackTwoPositions [

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
		               with: (MoonwalkEffect with:2)
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with:200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with:{SpeedCard new}).
	game playATurn.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 4.
	game playATurn.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 7.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 2.
	self assert: (game spaceshipOf: 'Seba') boxNumber equals: 2
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
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 4.
	game playATurn.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 7.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 2.
	self assert: (game spaceshipOf: 'Seba') boxNumber equals: 2
]

{ #category : #tests }
GameTest >> testValenLandsInASpeedupBoxInPositionFiveAndMovesToPositionNine [

	| dieOne dieTwo dieThree aDiceCup game newPosition boxSequence |
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
	newPosition := game spaceshipOf: 'Valen'.
	self assert: newPosition boxNumber equals: 9
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxSevenAndGoesBackFourBoxesToEndAtBoxNumberThree [

	| dieOne dieTwo dieThree aDiceCup game newPosition boxSequence |
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
	newPosition := game spaceshipOf: 'Valen'.
	self assert: newPosition boxNumber equals: 3.
	self assert: newPosition lapNumber equals: 1
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
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 9.
	self assert: (game spaceshipOf: 'Valen') lapNumber equals: 1
]
