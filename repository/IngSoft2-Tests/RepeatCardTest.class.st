Class {
	#name : #RepeatCardTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'repeatCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RepeatCardTest >> assert: aSpaceship distanceInBoxIs: aDistanceInBox in: aGame [ 
	self assert: (aGame distanceInBoxOf: aSpaceship) equals: aDistanceInBox.
]

{ #category : #tests }
RepeatCardTest >> assert: aSpaceship handHas: aNumberOfCards in: aGame [ 
	self assert: (aGame handOf: aSpaceship) numberOfCards equals: aNumberOfCards.
]

{ #category : #tests }
RepeatCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
RepeatCardTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize-1 timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #running }
RepeatCardTest >> setUp [
	super setUp.
	die:= LoadedDie with:6.
	repeatCard := RepeatCard new.
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInAAtomicBombEffect [

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
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInACardGiver [

	| game boxSequence deck |
	deck := Deck with: { repeatCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 16
		               with: (CardGiverEffect with: deck)
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'.
	game playATurn.
	self assert:'Spaceship Beta' handHas:3 in:game.
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInAHyperJumpEffect [

	| game boxSequence deck |
	deck := Deck with: { repeatCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 20)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:9 with:1 in:game.
	self assert: 'Spaceship Alpha' distanceInBoxIs:1 in:game.
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'.
	game playATurn.
	self assert:'Spaceship Beta' isAt:9 with:1 in:game.
	self assert: 'Spaceship Alpha' distanceInBoxIs:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInAMoonwalkEffect [

	| game boxSequence deck |
	deck := Deck with: { repeatCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (MoonwalkEffect with: 2)
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'.
	game playATurn.
	self assert:'Spaceship Beta' isAt:7 with:1 in:game.
	self assert:'Spaceship Alpha' isAt:3 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInANoEffect [

	| game boxSequence deck noEffect |
	deck := Deck with: { repeatCard }.
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 16 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAt: 7
		with: 1
		in: game.
	repeatCard playedOn: game by: 'Spaceship Beta' to: 'Spaceship Beta'.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAt: 7
		with: 1
		in: game
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInASpeedUpEffect [

	| game boxSequence deck |
	repeatCard := RepeatCard new.
	deck := Deck with: { repeatCard }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: SpeedUpEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:11 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'.
	game playATurn.
	self assert:'Spaceship Beta' isAt:11 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardAfterSpaceshipAlphaLandsInAWormholeEffect [

	| game boxSequence deck |
	deck := Deck with: { repeatCard }.

	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: WormHoleEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:3 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Alpha'.
	self assert:'Spaceship Alpha' isAt:1 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testSpaceshipBetaPlaysARepeatCardBeforeDiceAreThrown [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	repeatCard := RepeatCard new.
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
	repeatCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Alpha'.
	
	
]
