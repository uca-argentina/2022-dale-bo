Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
GameTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
GameTest >> playUntilFinshed: game [

	[ game hasFinished ] whileFalse: [ game playATurn ]
]

{ #category : #tests }
GameTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	(boardSize-1) timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
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
GameTest >> testAGameCannotBeCreatedWithABoardWithNegativeDistance [

	| die boxSequence noEffect |
	die := LoadedDie with: 6.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 13
		                for: { noEffect }) boxSequence.
	self
		should: [ SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: -200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }) ]
		raise: Error
		withMessage: 'Distances must be greater than zero'
]

{ #category : #tests }
GameTest >> testAGameCannotBePlayedAfterItHasFinished [

	| die game boxSequence noEffect |
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
	self playUntilFinshed: game.
	self
		assert: 'Spaceship Alpha'
		isAt: 13
		with: 2
		in: game.
	self
		should: [ game playATurn ]
		raise: Error
		withMessage: 'Turn cannot be played, game has finished'
]

{ #category : #tests }
GameTest >> testAGameDoesNotHaveAWinnerBecauseIsNotFinished [

	| die game boxSequence noEffect |
	die := Die with: 6.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 13
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
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

	| die game boxSequence |
	die := LoadedDie with: 5.
	boxSequence := self
		               sequenceOfNoEffectsOf: 13
		               with: AtomicBombEffect new
		               at: 11.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:  'Spaceship Alpha' isAt: 6 with: 1 in: game.
	game playATurn.
	self assert:  'Spaceship Beta' isAt: 6 with:1 in:game.
	game playATurn.
	game playATurn.
	self assert:  'Spaceship Beta' isAt: 1 with:1 in:game.
	self assert:  'Spaceship Alpha' isAt: 1 with: 1 in: game.
]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipInTheLastPositionOfTheLastLap [

	| die game boxSequence noEffect |
	die := LoadedDie with: 3.
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
	self deny: game hasFinished.
	self playUntilFinshed: game.
	self assert: game hasFinished.
	self
		assert: game winner
		isAt: 13
		with: 2
		in: game
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndSpaceshipAlphaEndsInPositionOneAndTheOthersInTheSecondAndThirdPosition [

	| die game boxSequence noEffect |
	die := LoadedDie with: 3.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 13
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game rankingOf: 'Spaceship Alpha') equals: 1.
	self assert: (game rankingOf: 'Spaceship Beta') equals: 2.
	self assert: (game rankingOf: 'Spaceship Gamma') equals: 3
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndSpaceshipAlphaWinsAndCannotGoThroughLastPositionOfLastLap [

	| die game boxSequence noEffect |
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
	self playUntilFinshed: game.
	self
		assert: 'Spaceship Alpha'
		isAt: 13
		with: 2
		in: game.
	self assert: game winner equals: 'Spaceship Alpha'
]

{ #category : #tests }
GameTest >> testAGameIsPlayedWithRandomDiceCupAndRandomBoardUntilItsFinished [

	| dieOne dieTwo dieThree aDiceCup game boxSequence noEffectBox speedUpBox moonwalkBox atomicBombBox wormholeEffectBox hyperjumpBox cardGiverBox effectsDistributions deck |
	dieOne := Die with: 6.
	dieTwo := Die with: 6.
	dieThree := Die with: 6.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { SpeedCard new }.
	noEffectBox := DiscreteProbabilityEvent for: NoEffect new with: 30.
	speedUpBox := DiscreteProbabilityEvent
		              for: SpeedUpEffect new
		              with: 20.
	moonwalkBox := DiscreteProbabilityEvent
		               for: (MoonwalkEffect with: 2)
		               with: 10.
	atomicBombBox := DiscreteProbabilityEvent
		                 for: AtomicBombEffect new
		                 with: 2.
	wormholeEffectBox := DiscreteProbabilityEvent
		                     for: WormHoleEffect new
		                     with: 20.
	hyperjumpBox := DiscreteProbabilityEvent
		                for: (HyperJumpEffect with: { 
					                 (Parsecs with: 2).
					                 (Lightyear with: 12) })
		                with: 8.
	cardGiverBox := DiscreteProbabilityEvent
		                for: (CardGiverEffect with: deck)
		                with: 10.
	effectsDistributions := { 
		                        noEffectBox.
		                        speedUpBox.
		                        moonwalkBox.
		                        atomicBombBox.
		                        wormholeEffectBox.
		                        hyperjumpBox.
		                        cardGiverBox }.
	boxSequence := (BoxesEffectsGenerator
		                generate: 50
		                for: effectsDistributions) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 1
		        diceCup: aDiceCup
		        and: deck.
	self playUntilFinshed: game.
	self assert: game hasFinished equals: true
]

{ #category : #tests }
GameTest >> testAGameIsPlayedWithRandomDiceCupUntilItsFinished [

	| dieOne dieTwo dieThree aDiceCup game boxSequence noEffect |
	dieOne := Die with: 10.
	dieTwo := Die with: 10.
	dieThree := Die with: 10.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	self playUntilFinshed: game.
	self assert: game hasFinished equals: true
]

{ #category : #tests }
GameTest >> testAGameReturnsPositionOfShipAfterItMoves [

	| die game boxSequence noEffect |
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
	self playUntilFinshed: game.
	self
		assert: 'Spaceship Alpha'
		isAt: 13
		with: 2
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 12
		with: 2
		in: game
]

{ #category : #tests }
GameTest >> testAGameStartsWithAllSpaceshipsAtPositionOne [

	| die game boxSequence noEffect |
	die := LoadedDie with: 6.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 13
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	self assert:  'Spaceship Alpha' isAt: 1 with:1 in:game.
	self assert:  'Spaceship Beta' isAt: 1 with:1 in:game.
	self assert:  'Spaceship Gamma' isAt: 1 with:1 in:game.
]

{ #category : #tests }
GameTest >> testAMoonwalkEffectCannotBeCreatedWithNegativePositionsToGoBack [

	self
		should: [ MoonwalkEffect with: -2 ]
		raise: Error
		withMessage: 'Number of boxes to send back muste be positive'
]

{ #category : #tests }
GameTest >> testCardGiverEffectCannotBeCreatedWithAnEmptyDeck [

	self
		should: [ CardGiverEffect with: (Deck with:{}) ]
		raise: Error
		withMessage: 'A deck must have at least one card'
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithLessThanTwoShips [

	| die boxSequence noEffect |
	die := LoadedDie with: 6.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.


	self
		should: [ 
			SpaceRaceGame
				with: { 'Spaceship Alpha' }
				boardWith: boxSequence
				distance: 200
				laps: 2
				diceCup: die
				and: (Deck with: { SpeedCard new }) ]
		raise: Error
		withMessage: 'Game must have more than one Ship'
]

{ #category : #tests }
GameTest >> testSpaceshipAlphaLandsInAMoonwalkAtBoxSevenAndMakeTheOthersGoBackTwoPositions [

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
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	game playATurn.
	self assert:'Spaceship Beta' isAt:4 with:1 in: game.
	game playATurn.
	self assert:'Spaceship Gamma' isAt:4 with:1 in: game.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in: game.
	self assert:'Spaceship Beta' isAt:2 with:1 in: game.
	self assert:'Spaceship Gamma' isAt:2 with:1 in: game.
	
]

{ #category : #tests }
GameTest >> testSpaceshipAlphaLandsInAMoonwalkAtBoxTwoAndDoesntAffectTheOtherSpaceshipsBecauseTheyAreAtPositionOneOfFirstLap [

	| dieOne game aDiceCup boxSequence |
	dieOne := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.}.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (MoonwalkEffect with: 2)
		               at: 2.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Spaceship Alpha' isAt:2 with:1 in: game.
	self assert:'Spaceship Beta' isAt:1 with:1 in: game.
	self assert:'Spaceship Gamma' isAt:1 with:1 in: game.
	
]

{ #category : #tests }
GameTest >> testSpaceshipAlphaLandsInASpeedupBoxInPositionFiveAndMovesToPositionNine [

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
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 9
		with: 1
		in: game
]

{ #category : #tests }
GameTest >> testSpaceshipAlphaLandsInWormholeAtBoxSevenAndGoesBackFourBoxesToEndAtBoxNumberThree [

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
		               at: 7.

	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Spaceship Alpha' isAt:3 with:1 in: game.
]

{ #category : #tests }
GameTest >> testSpaceshipAlphaLandsInWormholeAtBoxThreeOfLapTwoAndGoesBackOneLapEndingAtBoxSeven [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 9.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: WormHoleEffect new
		               at: 3.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Spaceship Alpha' isAt:9 with:1 in:game.
]

{ #category : #tests }
GameTest >> testSpaceshipAlphaRollsTenInATenBoxesBoardAndEndsUpWithAnExtraLap [

	| die game boxSequence noEffect |
	die:=LoadedDie with:10.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:  'Valen' isAt: 1 with:2 in:game.
]

{ #category : #tests }
GameTest >> testSpaceshipMovesSixPositionsWithLapsOfFiveBoxesAndTheSpaceshipEndsInLapTwoPositionTwo [
	| die game boxSequence noEffect |
	die := LoadedDie with: 6.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 5
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 2
		with: 2
		in: game.
]
