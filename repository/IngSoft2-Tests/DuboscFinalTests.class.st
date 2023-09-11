Class {
	#name : #DuboscFinalTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
DuboscFinalTests >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
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
DuboscFinalTests >> testSpaceshipAlphaLandsInASpeedupBoxWithPolarityFalseInPositionFiveAndTheSpachipBetaMovesToPositionFive [

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
	
	game giveTo: 'Spaceship Beta' card: (SpeedCard new). "BORRAR ESTO"
	game playATurn.
	self assert:'Spaceship Beta' isAt:8 with:1 in: game.
]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInAAtomicBombEffect [

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
