Class {
	#name : #DuboscFinalTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DuboscFinalTests >> assert: aSpaceship handHas: aNumberOfCards in: aGame [ 
	self assert: (aGame handOf: aSpaceship) numberOfCards equals: aNumberOfCards.
]

{ #category : #accessing }
DuboscFinalTests >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #accessing }
DuboscFinalTests >> assert: aSpaceshipName isAtPostion: aPositionNumber with: aLapNumber atDistance: aDistance in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
	self assert: spaceshipPosition distanceInBox equals: aDistance.
]

{ #category : #accessing }
DuboscFinalTests >> generateBoxesWith: cardGiverBox [

	^ (BoxesEffectsGenerator generate: 16 for: { cardGiverBox }) boxSequence
]

{ #category : #accessing }
DuboscFinalTests >> generateCardGiverBoxWith: deckForCardGiver [

	^ DiscreteProbabilityEvent
		  for: (CardGiverEffect with: deckForCardGiver)
		  with: 100
]

{ #category : #tests }
DuboscFinalTests >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	(boardSize-1) timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedAtomicBombInPositionSevenAndHasNoEffect [

	| die game boxSequence reversePolarityCard |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: AtomicBombEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:4 with:1 in:game.
	self assert:'Spaceship Beta' isAt:4 with:1 in:game.
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 7.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in:game.
	self assert:'Spaceship Beta' isAt:4 with:1 in:game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedCardGiverInPositionFourAndAllSpaceshipsRecieveOneCardExceptSpaceshipAlfa [

	| die game boxSequence reversePolarityCard deckForBoxes |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	deckForBoxes := Deck with: { AccelerationCard new }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: (CardGiverEffect  with: deckForBoxes)
		               at: 4.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 4.
	self assert:'Spaceship Beta' handHas:2 in:game.
	self assert:'Spaceship Gamma' handHas:2 in:game.
	game playATurn.
	self assert:'Spaceship Alpha' handHas:1 in:game.
	self assert:'Spaceship Beta' handHas:3 in:game.
	self assert:'Spaceship Gamma' handHas:3 in:game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedHyperJumpInPositionFourAndAllSpaceshipsMovesExceptSpaceshipAlfa [

	| die game boxSequence reversePolarityCard |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	boxSequence := self
		               sequenceOfNoEffectsOf: 9
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 4.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 4.
	self assert: 'Spaceship Alpha' isAtPostion: 1 with: 1 atDistance: 0 in: game.
	self assert: 'Spaceship Beta' isAtPostion: 1 with: 1 atDistance: 0 in: game.
	self assert: 'Spaceship Gamma' isAtPostion: 1 with: 1 atDistance: 0 in: game.
	game playATurn.
	self assert: 'Spaceship Alpha' isAtPostion: 4 with: 1 atDistance: 0 in: game.
	self assert: 'Spaceship Beta' isAtPostion: 1 with: 1 atDistance: 5 in: game.
	self assert: 'Spaceship Gamma' isAtPostion: 1 with: 1 atDistance: 5 in: game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedMoonWalkInPositionSevenAndSpaceshipAlfaMovesBackTwoPoisitions [

	| die game boxSequence reversePolarityCard |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	boxSequence := self
		               sequenceOfNoEffectsOf: 9
		               with: (MoonwalkEffect with: 2)
		               at: 4.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 4.
	self assert: 'Spaceship Alpha' isAt: 1 with: 1 in: game.
	self assert: 'Spaceship Beta' isAt: 1 with: 1 in: game.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt: 2 with: 1 in: game.
	self assert: 'Spaceship Beta' isAt: 1 with: 1 in: game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedSpeedupBoxInPositionFiveAndTheSpachipBetaMovesToPositionFive [

	| dieOne dieTwo dieThree aDiceCup game boxSequence reversePolarityCard |
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
	reversePolarityCard := ReversePolarityCard  new.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { reversePolarityCard}).
		
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 5.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 5
		with: 1
		in: game.
	self
		assert: 'Spaceship Beta'
		isAt: 5
		with: 1
		in: game.
]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedSprintEffectnPositionFourAndAllSpaceshipsExceptAlphaMovesTwoPositionCauseTheyHaveTwoCards [

	| die game boxSequence reversePolarityCard |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	boxSequence := self
		               sequenceOfNoEffectsOf: 9
		               with: (SprintEffect new)
		               at: 4.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma'.}
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 4.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt: 4 with: 1 in: game.
	self assert: 'Spaceship Beta' isAt: 3 with: 1 in: game.
	self assert: 'Spaceship Gamma' isAt: 3 with: 1 in: game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInAReversedWormHoleEffectnPositionSevenAndAllSpaceshipsExceptAlphaMovesTwoPositionCauseTheyHaveTwoCards [

	| die game boxSequence reversePolarityCard |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	boxSequence := self
		               sequenceOfNoEffectsOf: 9
		               with: (WormHoleEffect  new)
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma'.}
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 7.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt: 4 with: 1 in: game.
	self assert: 'Spaceship Beta' isAt: 4 with: 1 in: game.
	self assert: 'Spaceship Gamma' isAt: 4 with: 1 in: game.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt: 7 with: 1 in: game.
	self assert: 'Spaceship Beta' isAt: 1 with: 1 in: game.
	self assert: 'Spaceship Gamma' isAt: 1 with: 1 in: game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInASprintEffectAtBoxFiveAndMovesToPositionSevenCauseHeHasTwoCardsOnHand [

	| die game boxSequence |
	die := LoadedDie with: 4.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (SprintEffect new)
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in: game.
	game playATurn.
	self assert:'Spaceship Beta' isAt:7 with:1 in: game.
]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInASprintEffectAtBoxFiveAndMovesTwoPositionsCauseHeHasTwoCardsThenSpaceshipBetaPlayARepeatCardAndMovesTwoPositions [

	| die game boxSequence repeatCard |
	die := LoadedDie with: 4.
	repeatCard := RepeatCard new.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (SprintEffect new)
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { repeatCard }).
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in: game. 
	repeatCard playedOn: game by: 'Spaceship Beta' to: 'Spaceship Beta'.
	self assert:'Spaceship Beta' isAt:3 with:1 in: game.
]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaPlaysAReversePolarityCardOnANoEffectAndNothingHappens [

	| die game boxSequence reversePolarityCard noEffect |
	die := LoadedDie with: 3.
	reversePolarityCard := ReversePolarityCard  new.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma'.}
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reversePolarityCard}).
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 4.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt: 4 with: 1 in: game.
	self assert: 'Spaceship Beta' isAt: 4 with: 1 in: game.
	self assert: 'Spaceship Gamma' isAt: 4 with: 1 in: game.

]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipBetaPlaysARedoAfterAlphaPlaysAReversePolarityCardOnACardGiver [

	| game boxSequence deckForGame deckForCardGiver cardGiverBox die reversePolarityCard redoCard |
	reversePolarityCard := ReversePolarityCard  new.
	redoCard := RedoCard  new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { reversePolarityCard }.
	cardGiverBox := self generateCardGiverBoxWith: deckForCardGiver.
	boxSequence := self generateBoxesWith: cardGiverBox.
	die:= LoadedDie with:6.
	game := SpaceRaceGame
		        with:
		        { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	reversePolarityCard playedOn: game by: 'Spaceship Alpha' to: 7.
	game playATurn.
	self assert: 'Spaceship Alpha' handHas: 1 in: game.
	self assert: 'Spaceship Beta' handHas: 3 in: game.
	redoCard playedOn: game by: 'Spaceship Beta' to: 7.
	self assert: 'Spaceship Beta' handHas: 2 in: game.
	game playATurn.
	self assert: 'Spaceship Alpha' handHas: 1 in: game.
	self assert: 'Spaceship Beta' handHas: 3 in: game.

]
