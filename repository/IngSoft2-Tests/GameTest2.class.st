Class {
	#name : #GameTest2,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'accelerationCard',
		'cancelationCard',
		'overloadCard',
		'speedCard',
		'redoCard',
		'repeatCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest2 >> assert: aSpaceship handHas: aNumberOfCards in: aGame [ 
	self assert: (aGame handOf: aSpaceship) numberOfCards equals: aNumberOfCards.
]

{ #category : #accessing }
GameTest2 >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
GameTest2 >> assert: aSpaceshipName isAtPostion: aPositionNumber with: aLapNumber atDistance: aDistance in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
	self assert: spaceshipPosition distanceInBox equals: aDistance.
]

{ #category : #tests }
GameTest2 >> generateBoxesWith: cardGiverBox [

	^ (BoxesEffectsGenerator generate: 13 for: { cardGiverBox }) boxSequence
]

{ #category : #tests }
GameTest2 >> generateCardGiverBoxWith: deckForCardGiver [

	^ DiscreteProbabilityEvent
		  for: (CardGiverEffect with: deckForCardGiver)
		  with: 100
]

{ #category : #tests }
GameTest2 >> playUntilFinshed: game [

	[ game hasFinished ] whileFalse: [ game playATurn ]
]

{ #category : #tests }
GameTest2 >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	(boardSize-1) timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #tests }
GameTest2 >> setUp [
	super setUp.
	die:= LoadedDie with:6.
	accelerationCard := AccelerationCard new.
	cancelationCard := CancellationCard new.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
]

{ #category : #asserting }
GameTest2 >> should: aBlock raise: anError withMessage: anErrorMessage [

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
GameTest2 >> testAGameCannotBePlayedAfterItHasFinished [

	| game boxSequence noEffect |
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
GameTest2 >> testAGameHasABoardWithAAtomicBombInPositionElevenAndTheEffectDoenstChangeLaps [

	| game boxSequence |
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
	game playATurn .
	self assert:  'Spaceship Alpha' isAt: 6 with: 1 in: game.
	game playATurn.
	self assert:  'Spaceship Beta' isAt: 6 with:1 in:game.
	game playATurn .
	game playATurn.
	self assert:  'Spaceship Beta' isAt: 1 with:1 in:game.
	self assert:  'Spaceship Alpha' isAt: 1 with: 1 in: game.
]

{ #category : #tests }
GameTest2 >> testAGameReturnsPositionOfShipAfterItMoves [

	|  game boxSequence noEffect |
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
	game playATurn .
	self
		assert: 'Spaceship Alpha'
		isAt: 7
		with: 1
		in: game.
]

{ #category : #tests }
GameTest2 >> testAllPlayersLandInHyperJumpAtBoxFiveAndTheyMoveFirstFiveParsecsAndThenFourAndTheSequenceRestarts [

	|  game boxSequence |
	die:= LoadedDie with: 4.
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
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn .
	self
		assert: 'Spaceship Alpha'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
	game playATurn .
	self
		assert: 'Spaceship Beta'
		isAtPostion: 7
		with: 1
		atDistance: 0
		in: game.
	game playATurn .
	self
		assert: 'Spaceship Gamma'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
]

{ #category : #tests }
GameTest2 >> testPlayerLandsInABoxAndReceivesACard [

	| game boxSequence deck cardGiverBox |
	deck := Deck with: { 
			        speedCard.
			        overloadCard }.
	cardGiverBox := DiscreteProbabilityEvent
		                for: (CardGiverEffect with: deck)
		                with: 100.
	boxSequence := self generateBoxesWith: cardGiverBox.
	game := SpaceRaceGame
		        with:
		        { 'Spacehip Alpha'. 'Spacehip Beta'. 'Spacehip Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert: 'Spacehip Alpha' handHas: 3 in: game
]

{ #category : #tests }
GameTest2 >> testSpaceshipAlphaLandsInAMoonwalkAtBoxSevenAndMakeTheOthersGoBackTwoPositions [

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
	game playATurn .
	game playATurn .
	self assert:'Spaceship Beta' isAt:4 with:1 in: game.
	game playATurn .
	self assert:'Spaceship Gamma' isAt:4 with:1 in: game.
	game playATurn .
	self assert:'Spaceship Alpha' isAt:7 with:1 in: game.
	self assert:'Spaceship Beta' isAt:2 with:1 in: game.
	self assert:'Spaceship Gamma' isAt:2 with:1 in: game.
]

{ #category : #tests }
GameTest2 >> testSpaceshipAlphaLandsInWormholeAtBoxThreeOfLapTwoAndGoesBackOneLapEndingAtBoxSeven [

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
GameTest2 >> testSpaceshipAlphaPlaysASpeedCardToSpaceshipBetaAndAddsOneToSpaceshipBetasRoll [

	| game boxSequence deck noEffect |
	deck := Deck with: { speedCard }.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := self generateBoxesWith: noEffect.
	game := SpaceRaceGame
		        with:
		        { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.

	speedCard playedOn: game by: 'Spaceship Alpha' to: 'Spaceship Beta'.
	game playATurn .
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 8
		with: 1
		in: game
]

{ #category : #tests }
GameTest2 >> testSpaceshipAlphaPlaysAnAccelerationCardToAllPlayersAndTheyAddOneToTheirRoll [

	| game boxSequence deck noEffect |
	deck := Deck with: { accelerationCard }.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := self generateBoxesWith: noEffect.
	game := SpaceRaceGame 
		        with:
		        { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	accelerationCard playedOn: game by: 'Spaceship Alpha'.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 1
		with: 1
		in: game.
	self
		assert: 'Spaceship Alpha'
		isAt: 8
		with: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 8
		with: 1
		in: game.
	game playATurn.
	game playATurn.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 2
		with: 2
		in: game
]

{ #category : #tests }
GameTest2 >> testSpaceshipAlphaPlaysAnOverloadCardToSpaceshipBetaAndReduceItsDieRollByOne [

	| game boxSequence deck cardGiverBox |
	deck := Deck with: { overloadCard }.
	cardGiverBox := DiscreteProbabilityEvent
		                for: (CardGiverEffect with: deck)
		                with: 100.
	boxSequence := self generateBoxesWith: cardGiverBox.
	game := SpaceRaceGame
		        with:
		        { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	overloadCard
		playedOn: game
		by: 'Spaceship Alpha'
		to: 'Spaceship Beta'.
	game playATurn.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 5
		with: 1
		in: game
]

{ #category : #tests }
GameTest2 >> testSpaceshipBetaPlaysARedoCardAfterHePlaysAOverloadCard [

	| game boxSequence deckForGame deckForCardGiver cardGiverBox |
	deckForGame := Deck with: { overloadCard }.
	deckForCardGiver := Deck with: { redoCard }.
	cardGiverBox := self generateCardGiverBoxWith: deckForCardGiver.
	boxSequence := self generateBoxesWith: cardGiverBox.
	game := SpaceRaceGame
		        with:
		        { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self
		assert: 'Spaceship Gamma'
		isAt: 7
		with: 1
		in: game.
	overloadCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Gamma'.
	redoCard playedOn: game by: 'Spaceship Beta' to: 'Spaceship Gamma'.
	game playATurn.
	game playATurn.
	self
		assert: 'Spaceship Gamma'
		isAt: 9
		with: 1
		in: game
]

{ #category : #tests }
GameTest2 >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInAAtomicBombEffect [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { repeatCard }.

	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: AtomicBombEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:1 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Alpha'.
	self assert:'Spaceship Beta' isAt:1 with:1 in:game.
	self assert:'Spaceship Alpha' isAt:1 with:1 in:game.
]

{ #category : #tests }
GameTest2 >> testSpeedup [
	|  game boxSequence speedUpEffect |
	die := LoadedDie with: 6.
	speedUpEffect := DiscreteProbabilityEvent for: SpeedUpEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { speedUpEffect })
		               boxSequence.
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
		isAt: 11
		with: 1
		in: game.
]
